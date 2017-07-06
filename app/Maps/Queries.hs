module Maps.Queries where

import Database
import Database.Selda
import Maps.Types
import Protolude hiding (Map)

import qualified Maps.Table as Maps


all :: RelationalQuery x Map
all = select Maps.table


byId :: Int -> RelationalQuery x Map
byId theId = do
    map <- select Maps.table

    let id :*: _ = selectors Maps.table
    restrict (map ! id .== literal theId)

    return map
