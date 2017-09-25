{-| Generic bits for handlers.
-}
module Handlers where

import Data.Pool (Pool)
import Database.Selda.Backend (SeldaConnection)
import Flow
import Protolude hiding (State)
import Servant (ServantErr, err404)

import qualified Servant (Handler)


-- State


{-| Handlers with extra state.
-}
newtype State = State
    { databasePool :: Pool SeldaConnection
    }


type Handler =
    ReaderT State Servant.Handler


{-| Fetching the extra state from inside the handlers.
-}
fetchState :: MonadReader a f => (a -> b) -> f b
fetchState fn =
    fmap fn ask



-- Shortcuts


{-| Maybe we got an item from the database, or maybe not.

    If so, return that item.
    If not, render a 404 error.

-}
showOrNotFound :: IO (Maybe a) -> Handler a
showOrNotFound io = do
    maybeItem <- liftIO io

    case maybeItem of
        Just item   -> return item
        Nothing     -> throwError err404
