module Main where

import Api (Api)
import Protolude
import Servant (Proxy)
import Servant.Docs as Docs

import qualified Data.Text as Text (pack)


{-| Generate documentation.

    Table:
    - API docs

-}
main :: IO ()
main =
    writeFile "docs/API.md" (Text.pack $ Docs.markdown api)



-- Documentation for the API


api :: Docs.API
api = docs (Proxy :: Proxy Api)
