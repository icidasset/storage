module Main where

import Api
import Database
import Environment
import Network.Wai.Cli
import Protolude
import Servant


{-| Setup a server for the API.

    Notes:
    - Loads the .env file in the dev environment (see the `Environment` module)
    - Uses the `wai-cli` package (see the docs on that package for more info)

-}
main :: IO ()
main = do
    env <- appEnvironment

    case env of
        Development -> loadDotEnvFile
        _           -> return ()

    defWaiMain application


application :: Application
application =
    serve proxy server
