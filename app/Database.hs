module Database where

import Database.Selda
import Database.Selda.PostgreSQL
import GHC.Generics
import Protolude
import System.Envy as Envy

import qualified Maps.Db as Maps


-- Extend Envy


instance Var (Maybe Text) where
    toVar = show
    fromVar = readMaybe



-- Config


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



-- Migrations


create :: SeldaM ()
create =
    tryCreateTable Maps.table


drop :: SeldaM ()
drop =
    tryDropTable Maps.table
