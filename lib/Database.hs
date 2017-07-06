module Database where

import Data.Aeson (FromJSON, ToJSON, parseJSON, toJSON)
import Database.Selda as Selda
import Database.Selda.Backend
import Database.Selda.Generic as Selda
import Database.Selda.PostgreSQL
import Flow
import GHC.Generics
import Protolude
import Servant (Handler)
import System.Envy as Envy


-- Types


{-| Type alias for a Query with a Relation.
-}
type RelationalQuery s a = Query s (Cols s (Relation a))


{-| Implement JSON for RowID
-}
instance FromJSON RowID where
    parseJSON _ = return invalidRowId

instance ToJSON RowID where
    toJSON rowId = toJSON (fromRowId rowId)



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



-- Raw queries


rawQuery :: Text -> IO ()
rawQuery theQuery = connect $ do
    backend     <- seldaBackend
    _           <- liftIO (runStmt backend theQuery [])

    return ()



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
