module Migrations where

import Database
import Database.Selda as Selda
import Protolude (IO, ($))

import qualified Maps.Table as Maps


-- Up


up :: IO ()
up = perform $ do
    tryCreateTable Maps.table



-- Down


down :: IO ()
down = perform $ do
    tryDropTable Maps.table
