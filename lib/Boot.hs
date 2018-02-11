module Main where

import Api
import Control.Monad.Trans.Reader (runReaderT)
import Data.Pool
import Environment
import Flow
import Handlers (State(..))
import Network.Wai.Cli
import Prelude (read)
import Protolude hiding (State)
import Servant
import System.Environment (lookupEnv)

import qualified Database
import qualified Database.Selda.PostgreSQL as Selda
import qualified Handlers


{-| Setup a server for the API.

    Notes:
    - Loads the .env file in the dev environment (see the `Environment` module)
    - Sets up a database pool (to not exceed the max connection to the database)
    - Sets up a shared handlers state (every `Handler` has access to this)
    - Uses the `wai-cli` package (see the docs on that package for more info)

-}
main :: IO ()
main = do
    env     <- appEnvironment

    case env of
        Development -> loadDotEnvFile
        _           -> return []

    -- Initial state
    state   <- initialState env

    -- Api
    let api = Proxy :: Proxy Api

    -- Initialize launch sequence
    Api.server
        |> Servant.hoistServer api (transform state)
        |> Servant.serve api
        |> defWaiMain


{-| Initial state for our handlers.
-}
initialState :: Env -> IO Handlers.State
initialState env = do
    --
    -- Database pool
    --
    config          <- Database.config
    maybePoolSize   <- lookupEnv "PG_POOL_SIZE"

    let poolStart   = Selda.pgOpen config
    let poolEnd     = Selda.seldaClose
    let poolSize    = fromMaybe 20 (fmap read maybePoolSize)

    pool            <- createPool poolStart poolEnd poolSize 0.5 poolSize

    --
    -- Result
    --
    return State
        { databasePool = pool
        }


{-| Transforms our custom `Handler` into a normal Servant `Handler`.
-}
transform :: State -> Handlers.Handler a -> Servant.Handler a
transform =
    flip runReaderT
