module Main where

import Control.Monad (liftM2)
import Data.Bifunctor (Bifunctor, bimap)
import Data.List (findIndex, tails)
import GHC.OldList (inits)

main :: IO ()
main = do
  print $ equilibriumIndex [1 .. 4]
  print $ equilibriumIndex [1, 2, 1]
  print $ equilibriumIndex [1.1, -1.1, 2, 0]
  print $ equilibriumIndex2 [1 .. 4]
  print $ equilibriumIndex2 [1, 2, 1]
  print $ equilibriumIndex2 [1.1, -1.1, 2, 0]

equilibriumIndex :: (Eq a, Num a) => [a] -> Maybe Int
equilibriumIndex xs = go 0 xs
  where
    go n xs
      | n < length xs =
        if sum (take n xs) == sum (drop (n + 1) xs)
          then Just n
          else go (succ n) xs
      | otherwise = Nothing

equilibriumIndex2 :: (Eq a, Num a) => [a] -> Maybe Int
equilibriumIndex2 =
  findIndex
    (uncurry (==) . both sum)
    . liftM2
      zip
      (init . inits)
      (tail . init . tails)

both :: Bifunctor f => (a -> b) -> f a a -> f b b
both f = bimap f f