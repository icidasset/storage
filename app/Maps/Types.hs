module Maps.Types where

import Data.Aeson (FromJSON, ToJSON)
import Database
import Database.Selda (RowID)
import Database.Selda.Unsafe (unsafeRowId)
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


sample :: Map
sample =
    Map
        { id = unsafeRowId 1
        , name = "Sample"
        , fields = "a,b,c"
        }


instance ToSample Map where
    toSamples _ = singleSample sample
