module Maps.Queries where

import Database
import Database.Selda
import Database.Selda.Unsafe
import Maps.Types
import Protolude hiding (Map)

import qualified Maps.Table as Maps


-- Standard


all :: RelationalQuery x Map
all = select Maps.table


byId :: Int -> RelationalQuery x Map
byId = Database.byId Maps.table
