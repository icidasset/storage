module Maps.Handlers where

import Maps.Types
import Prelude hiding (id)
import Servant (Handler)


-- Create


create :: Map -> Handler Map
create map =
    return map { id = 1 }



-- Index


index :: Handler [Map]
index =
    return []



-- Show


show :: Int -> Handler Map
show _ =
    return Map { id = 1, name = "Some map", fields = "" }
