module Main where

import Prelude (unlines)
import Protolude
import System.Environment (getArgs)

import qualified Environment
import qualified Migrations


main :: IO ()
main = do
    args <- getArgs

    -- Fun w/ flags
    let operation = fromMaybe "help" $ headMay args

    -- Load environment variables
    Environment.loadDotEnvFile

    -- Operate!
    case operation of
        "help" ->
            putStr $ unlines
                [ "Commands:\n"
                , "help"
                , "db:migrate"
                , "db:rollback"
                ]

        "db:migrate" ->
            Migrations.up

        "db:rollback" ->
            Migrations.down

        _ ->
            putStr ("Command not found, see `help` for the available commands." :: Text)
