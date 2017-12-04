module Environment where

import Protolude
import System.Environment (lookupEnv)

import qualified Configuration.Dotenv as Dotenv
import qualified Configuration.Dotenv.Types as Dotenv
import qualified Data.Maybe as Maybe


data Env
    = Development
    | Production
    | Test


{-| Determine the current environment for the app.

    Usage: Set `APP_ENV` to either: dev, test or prod.
    Whenever it is set something else, the environment will be `Production`.
    When it isn't set at all, the environment will be `Development`

-}
appEnvironment :: IO Env
appEnvironment = do
    maybeEnv <- lookupEnv "APP_ENV"

    case maybeEnv of
        Just "dev"  -> return Development
        Just "test" -> return Test
        Just _      -> return Production
        Nothing     -> return Development



-- Utils


loadDotEnvFile :: IO ()
loadDotEnvFile =
    Dotenv.loadFile
        Dotenv.Config
            { configExamplePath = [ ".env.example"]
            , configOverride = False
            , configPath = [ ".env" ]
            }
