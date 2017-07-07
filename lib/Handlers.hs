{-| Generic bits for handlers.
-}
module Handlers where

import Flow
import Protolude
import Servant (Handler, err404)


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
