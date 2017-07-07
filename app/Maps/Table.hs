module Maps.Table where

import Database.Selda as Selda
import Database.Selda.Generic as Selda
import Maps.Types
import Protolude hiding (Map)


{-| Schema for a `Map`.

    Transform the `Map` type into a Schema,
    with `id` as the auto-incrementing primary key.

-}
genericTable :: GenTable Map
genericTable = Selda.genTable "maps" [ id :- autoPrimaryGen ]


{-| Unpacked schema.

    {!} This will be used most of the time.

-}
table :: Table (Relation Map)
table = Selda.gen genericTable
