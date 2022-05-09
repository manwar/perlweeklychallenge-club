module Main where

import Data.Bifunctor (first)
import Data.Bool (bool)

main :: IO ()
main = print $ fizzBuzz 20

fizzBuzz :: Int -> [String]
fizzBuzz max =
  map
    ( \x ->
        let mfizzBuzz = fizzBuzzCycle !! pred x
         in if not $ null mfizzBuzz then mfizzBuzz else show x
    )
    [1 .. max]
  where
    fizzBuzzCycle = zipWith (++) (cycle ["", "", "Fizz"]) (cycle ["", "", "", "", "Buzz"])
