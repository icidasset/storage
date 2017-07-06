module Database where

import Database.Selda as Selda
import Database.Selda.Generic as Selda
import Database.Selda.PostgreSQL
import Flow
import GHC.Generics
import Maps.Types (Map)
import Protolude hiding (Map)
import Servant (Handler)
import System.Envy as Envy


-- Types


{-| Type alias for a Query with a Relation.
-}
type RelationalQuery s a = Query s (Cols s (Relation a))



-- Querying


{-| Execute a query that uses `Relation`s (ie. generics).
-}
all :: (Res a ~ Relation r, Relational r, Result a) => Query s a -> SeldaM [r]
all theQuery =
    theQuery
        |> Selda.query
        |> fmap Selda.fromRels


one :: (Res a ~ Relation r, Relational r, Result a) => Query s a -> SeldaM (Maybe r)
one theQuery =
    theQuery
        |> Database.all
        |> fmap headMay



-- Config


{-| Extend Envy.
-}
instance Var (Maybe Text) where
    toVar = show
    fromVar = readMaybe


{-| PostgreSQL config & environment variables

> PG_HOST
> PG_PORT
> PG_DATABASE
> PG_USERNAME (optional)
> PG_PASSWORD (optional)

-}
deriving instance Generic PGConnectInfo
instance DefConfig PGConnectInfo where defConfig = defaultConfig
instance FromEnv PGConnectInfo


defaultConfig :: PGConnectInfo
defaultConfig =
    PGConnectInfo "localhost" 5432 "storage" Nothing Nothing


config :: IO PGConnectInfo
config = do
    config <- Envy.decode :: IO (Maybe PGConnectInfo)
    return $ fromMaybe defaultConfig config



-- Connections


connect :: SeldaM a -> IO a
connect operation = do
    pgConfig <- liftIO config
    withPostgreSQL pgConfig operation


connectAndLift :: SeldaM a -> Handler a
connectAndLift operation = liftIO (connect operation)
