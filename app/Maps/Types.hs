module Maps.Types where

import Data.Aeson (FromJSON, ToJSON)
import Database
import Database.Selda (RowID)
import GHC.Generics
import Protolude hiding (Map)
import Servant.Docs


-- 🗺


data Map =
    Map
        { id :: RowID
        , name :: Text
        , fields :: Text
        }


deriving instance Generic Map
deriving instance Show Map

instance FromJSON Map
instance ToJSON Map



-- Documentation


instance ToSample Map where
    toSamples _ = []
