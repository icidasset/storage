module Main where

import Servant.Docs as Docs
import qualified Api


api :: Docs.API
api = docs Api.proxy


main :: IO ()
main =
    writeFile "docs/API.md" (Docs.markdown api)
