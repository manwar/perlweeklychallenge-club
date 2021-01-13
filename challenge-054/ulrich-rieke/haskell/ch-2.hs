module Collatz
  where
import Control.Monad.State.Lazy
import Data.List( sortBy )

findSequence :: State ( Int , [Int] ) [Int]
findSequence = do
  ( n, sequence ) <- get
  if n == 1
      then return (sequence )
  else do
      put (nextNum n , sequence ++ [nextNum n])
      findSequence


nextNum :: Int -> Int
nextNum n
  |even n = div n 2
  |odd n = n * 3 + 1

numbersequence :: Int -> [Int]
numbersequence n = evalState findSequence ( n , [] )

solution :: [(Int, Int)]
solution = take 20 $ sortBy mySorter $ map (\i -> (i , length $ numbersequence i) ) [1..1000000]
  where
      mySorter :: (Int, Int ) -> (Int , Int ) -> Ordering
      mySorter p1 p2
    |snd p1 > snd p2 = LT
    |snd p1 == snd p2 = EQ
    |snd p1 < snd p2 = GT

