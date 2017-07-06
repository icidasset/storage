module Main where

import Protolude
import Servant.Docs as Docs

import qualified Api
import qualified Data.Text as Text (pack)


{-| Generate documentation.

    Table:
    - API docs

-}
main :: IO ()
main =
    writeFile "docs/API.md" (Text.pack $ Docs.markdown api)



-- Modules


api :: Docs.API
api = docs Api.proxy
