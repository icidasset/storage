module Main where

import Api (Api)
import Flow
import Protolude
import Servant (Proxy)
import Servant.Docs as Docs

import qualified Data.Text as Text (pack, replace)


{-| Generate documentation.

    Table:
    - API docs

-}
main :: IO ()
main =
    api
        |> Docs.markdown
        |> Text.pack
        |> Text.replace "    ```" "```"
        |> writeFile "docs/API.md"



-- Documentation for the API


api :: Docs.API
api = docs (Proxy :: Proxy Api)
