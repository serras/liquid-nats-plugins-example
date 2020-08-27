{-# language DataKinds, GADTs, TypeOperators #-}
module Example where

import GHC.TypeLits

data GList n a where
  GNil  :: GList 0 a
  GCons :: a -> GList n a -> GList (n + 1) a

gHead :: CmpNat n 0 ~ 'GT => GList n a -> a
-- gHead GNil = undefined
gHead (GCons x _) = x

gAppend :: GList n a -> GList m a -> GList (n + m) a
gAppend GNil         ys = ys
gAppend (GCons x xs) ys = GCons x (gAppend xs ys)