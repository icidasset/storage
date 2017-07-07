module Maps.Handlers where

import Database.Selda (SeldaM, fromRowId)
import Flow
import Maps.Types
import Protolude hiding (Map)
import Servant (Handler)

import qualified Database
import qualified Handlers
import qualified Maps.Queries
import qualified Maps.Table as Maps


-- Create


create :: Map -> Handler Map
create map =
    map
        |> createComputation
        |> Database.perform
        |> Handlers.showOrNotFound


createComputation :: Map -> SeldaM (Maybe Map)
createComputation map = do
    rowId <- Database.insert Maps.table map

    -- Return map with id
    Database.one (Maps.Queries.byId $ fromRowId rowId)



-- Index


index :: Handler [Map]
index =
    Maps.Queries.all
        |> Database.all
        |> Database.performAndLift



-- Show


show :: Int -> Handler Map
show mapId =
    mapId
        |> Maps.Queries.byId
        |> Database.one
        |> Database.perform
        |> Handlers.showOrNotFound
