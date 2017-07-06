module Maps.Handlers where

import Database.Selda as Selda
import Flow
import Maps.Types
import Protolude hiding (Map)
import Servant (Handler)

import qualified Database
import qualified Maps.Queries
import qualified Maps.Table


-- Create


create :: Map -> Handler (Maybe Map)
create map = Database.connectAndLift $ do
    id <- Selda.insert Maps.Table.table [ def :*: name map :*: fields map ]
    Database.one (Maps.Queries.byId id)



-- Index


index :: Handler [Map]
index =
    Maps.Queries.all
        |> Database.all
        |> Database.connectAndLift



-- Show


show :: Int -> Handler (Maybe Map)
show id =
    id
        |> Maps.Queries.byId
        |> Database.one
        |> Database.connectAndLift
