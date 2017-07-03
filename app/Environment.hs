module Environment where

import Protolude
import System.Environment (lookupEnv)

import qualified Configuration.Dotenv as Dotenv
import qualified Data.Maybe as Maybe


data Env
    = Dev
    | Prod
    | Test


appEnvironment :: IO Env
appEnvironment = do
    maybeEnv <- lookupEnv "APP_ENV"

    case maybeEnv of
        Just "dev"  -> return Dev
        Just "test" -> return Test
        Just _      -> return Prod
        Nothing     -> return Dev


loadDotEnvFile :: IO ()
loadDotEnvFile =
    Dotenv.loadFile False ".env"
