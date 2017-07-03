module Maps.Types where

import Data.Aeson (FromJSON, ToJSON)
import Data.Text (Text)
import GHC.Generics
import Protolude hiding (Map)
import Servant.Docs


-- Data


data Map =
    Map
        { id :: Int
        , fields :: Text
        , name :: Text
        }


deriving instance Generic Map
deriving instance Show Map

instance FromJSON Map
instance ToJSON Map

instance ToSample Map where
    toSamples _ = []
