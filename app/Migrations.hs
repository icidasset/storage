module Migrations where

import Database
import Database.Selda as Selda
import Protolude (IO, ($))

import qualified Maps.Table as Maps


-- Up


up :: IO ()
up = connect $ do
    tryCreateTable Maps.table



-- Down


down :: IO ()
down = connect $ do
    tryDropTable Maps.table
