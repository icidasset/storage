module Database where

import Data.Aeson (FromJSON, ToJSON, parseJSON, toJSON)
import Data.Pool (Pool)
import Database.Selda as Selda
import Database.Selda.Backend
import Database.Selda.Generic as Selda
import Database.Selda.PostgreSQL
import Database.Selda.Unsafe
import Flow
import GHC.Generics hiding ((:*:))
import Handlers (Handler)
import Protolude hiding ((:*:))
import System.Envy as Envy

import qualified Data.Pool as Pool (withResource)


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



-- Execute Queries


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



-- Mutations


insert table item =
    let
        (_ :*: rels) = toRel item
    in
    Selda.insertWithPK table [ def :*: rels ]



-- Building Queries


byId table theId = do
    item <- select table

    let id :*: _    = selectors table
    let rowID       = unsafeRowId theId

    restrict (item ! id .== literal rowID)

    return item



-- Raw Queries


rawQuery :: Pool SeldaConnection -> Text -> IO ()
rawQuery pool theQuery = perform pool $ do
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

> PG_HOST (optional)
> PG_PORT (optional)
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



-- Performances


{-| Assign 1 action to the pool and perform the database operation.
-}
perform :: Pool SeldaConnection -> SeldaM a -> IO a
perform pool operation =
    Pool.withResource pool (runSeldaT operation)


{-| Same as `perform`, but lifts the IO operation in a Handler.
-}
performAndLift :: Pool SeldaConnection -> SeldaM a -> Handler a
performAndLift pool operation =
    liftIO (perform pool operation)


{-| Perform a database operation without using a pool.
    Example use-case: database migrations
-}
performWithNewConnection :: SeldaM a -> IO a
performWithNewConnection operation =  do
    pgConfig <- liftIO config
    withPostgreSQL pgConfig operation
