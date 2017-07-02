module Main where

import Api
import Network.Wai.Handler.Warp (run)
import Servant


-- 🍯


main :: IO ()
main =
    run 8000 application


application :: Application
application =
    serve proxy server
