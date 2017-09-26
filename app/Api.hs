module Api where

import Maps.Types
import Protolude (Int, Maybe)
import Servant
import Servant.Docs

import qualified Handlers
import qualified Maps.Handlers as Maps


{-| The API.

    {!} The order of the routes must match the order of the handlers
        (see `server` below, you will get a compiler error if it doesn't match)
-}
type Api

    --
    -- 🗺 Maps
    --

    -- GET /maps
    = "maps" :> Get '[JSON] [Map]

    -- GET /maps/:map_id
    :<|> "maps" :> Capture "map_id" Int :> Get '[JSON] Map

    -- POST /maps
    :<|> "maps" :> ReqBody '[JSON] Map :> Post '[JSON] Map



-- Server


server :: ServerT Api Handlers.Handler
server =

    --
    -- 🗺 Maps
    --

    Maps.index
    :<|> Maps.show
    :<|> Maps.create



-- Documentation


instance ToCapture (Capture "map_id" Int) where
    toCapture _ =
        DocCapture
            "map_id"
            "The `id` of the Map"
