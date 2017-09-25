module Maps.Handlers where

import Database.Selda (SeldaM, fromRowId)
import Flow
import Handlers (Handler, fetchState)
import Maps.Types
import Protolude hiding (Map)

import qualified Database
import qualified Handlers
import qualified Maps.Queries
import qualified Maps.Table as Maps


-- Create


create :: Map -> Handler Map
create map = do
    db <- fetchState Handlers.databasePool

    map
        |> createComputation
        |> Database.perform db
        |> Handlers.showOrNotFound


createComputation :: Map -> SeldaM (Maybe Map)
createComputation map = do
    rowId <- Database.insert Maps.table map

    -- Return map with id
    Database.one (Maps.Queries.byId $ fromRowId rowId)



-- Index


index :: Handler [Map]
index = do
    db <- fetchState Handlers.databasePool

    Maps.Queries.all
        |> Database.all
        |> Database.performAndLift db



-- Show


show :: Int -> Handler Map
show mapId = do
    db <- fetchState Handlers.databasePool

    mapId
        |> Maps.Queries.byId
        |> Database.one
        |> Database.perform db
        |> Handlers.showOrNotFound
