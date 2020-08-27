module Currency where

import Data.Set (Set)
import qualified Data.Set as S

{-@ measure value @-}
{-@ measure currency @-}

data Amount
  = Amount { value    :: Integer
           , currency :: String }
  deriving (Eq, Show)

data Rates
  = EndRates
  | Rate { from    :: String
         , dollars :: Float
         , next    :: Rates }

{-@ measure rates @-}
rates :: Rates -> Set String
rates EndRates = S.empty
rates (Rate c _ rs)
  = S.singleton c `S.union` rates rs

{-@ convert :: rs : Rates
            -> { a : Amount | Set_mem (currency a) (rates rs) }
            -> { s : String | Set_mem s (rates rs) }
            -> { r : Amount | currency r = s }
@-}
convert :: Rates -> Amount -> String -> Amount
convert = undefined


good, bad :: Amount
(good, bad)
  = let exampleRates = Rate "EUR" 1.12 (Rate "JPY" 0.01 EndRates)
    in ( convert exampleRates (Amount 10 "EUR") "EUR"
       , convert exampleRates (Amount 10 "JPY") "EUR" )