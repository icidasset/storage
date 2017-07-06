module Maps.Table where

import Database.Selda as Selda
import Database.Selda.Generic as Selda
import Maps.Types
import Protolude hiding (Map)


{-| Schema for a `Map`
-}
genericTable :: GenTable Map
genericTable = Selda.genTable "maps" [ id :- autoPrimaryGen ]


{-| Unpacked schema
-}
table :: Table (Relation Map)
table = Selda.gen genericTable
