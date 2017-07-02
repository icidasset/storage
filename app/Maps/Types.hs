module Maps.Types where

import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics
import Servant.Docs


-- Data


data Map =
    Map
        { id :: Int
        , fields :: [Field]
        }


deriving instance Generic Map
deriving instance Show Map

instance FromJSON Map
instance ToJSON Map

instance ToSample Map where
    toSamples _ =
        [ ( "Initial", Map { id = 1, fields = [] } )
        ]



-- Fields


type Field =
    ( String        -- Name
    , FieldType     -- Type
    )


data FieldType
    = String
    | Number


deriving instance Generic FieldType
deriving instance Show FieldType

instance FromJSON FieldType
instance ToJSON FieldType
