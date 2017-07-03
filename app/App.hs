module Main where

import Api
import Database
import Environment
import Network.Wai.Cli
import Protolude
import Servant


-- 🍯


main :: IO ()
main = do
    env <- appEnvironment

    case env of
        Dev -> loadDotEnvFile
        _   -> return ()

    defWaiMain application


application :: Application
application =
    serve proxy server
