module Main where

import Control.Monad (liftM2)
import Data.Bool (bool)
import qualified Data.IntSet as Set
import Data.List (unfoldr)
import Data.Tuple (swap)

main :: IO ()
main = print $ take 8 $ filter isHappyNumber [1 ..]

isHappyNumber :: Int -> Bool
isHappyNumber = go mempty
  where
    go _ 1 = True
    go tested x =
      not (x `Set.member` tested)
        && go (Set.insert x tested) (sum $ map (^ 2) $ digits x)

digits :: Integral a => a -> [a]
digits = reverse . unfoldr ((bool Nothing . (Just . swap . flip divMod 10)) <*> (/= 0))
