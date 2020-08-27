module Example where

data LHList a = LHNil | LHCons a (LHList a)
              deriving (Eq, Show)

{-@ measure lhLength @-}
{-@ lhLength :: LHList a -> { v : Int | v >= 0 } @-}
lhLength :: LHList a -> Int
lhLength LHNil         = 0
lhLength (LHCons _ xs) = 1 + lhLength xs

{-@ lhHead :: { xs : LHList a | lhLength xs > 0 } -> a @-}
lhHead :: LHList a -> a
lhHead (LHCons x _) = x

{-
wrong :: Int
wrong = lhHead LHNil
-}

{-@ lhAppend :: xs : LHList a -> ys : LHList a
             -> { zs : LHList a | lhLength zs == lhLength xs + lhLength ys } @-}
lhAppend :: LHList a -> LHList a -> LHList a
lhAppend LHNil         ys = ys
lhAppend (LHCons x xs) ys = LHCons x (lhAppend xs ys)