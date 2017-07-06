module Main where

import Flow
import Prelude (unlines)
import Protolude
import System.Environment (getArgs, lookupEnv)
import System.Process (callCommand)

import qualified Data.Maybe as Maybe
import qualified Data.Text as Text
import qualified Database
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
                [ "Commands:"
                , ""
                , "db:create"
                , "db:drop"
                , "db:migrate"
                , "db:rollback"
                , "help"
                ]

        "db:create" -> do
            maybeDbName <- lookupEnv "PG_DATABASE"

            -- TODO: Needs improvement
            callCommand ("createdb " <> Maybe.fromJust maybeDbName)

        "db:drop" -> do
            maybeDbName <- lookupEnv "PG_DATABASE"

            -- TODO: Needs improvement
            callCommand ("dropdb " <> Maybe.fromJust maybeDbName)

        "db:migrate" ->
            Migrations.up

        "db:rollback" ->
            Migrations.down

        _ ->
            putStr ("Command not found, see `help` for the available commands." :: Text)
