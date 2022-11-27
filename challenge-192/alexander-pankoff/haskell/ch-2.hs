#!/usr/bin/env stack
{- stack --resolver lts-20.1 runghc --package HUnit -}
module Main where

import           Test.HUnit
import           Data.List (singleton)
import           GHC.Natural (Natural)

main = runTestTT
  $ TestList
    [ TestCase $ assertEqual "Example 1" (Just 4) (equalDistribution [1, 0, 5])
    , TestCase $ assertEqual "Example 2" Nothing (equalDistribution [0, 2, 0])
    , TestCase $ assertEqual "Example 3" (Just 2) (equalDistribution [0, 3, 0])
    , TestCase
      $ assertEqual "Example (empty list)" (Just 0) (equalDistribution mempty)
    , TestCase
      $ assertEqual
        "Example (singleton list)"
        (Just 0)
        (equalDistribution $ singleton 4)]

equalDistribution :: [Int] -> Maybe Natural
equalDistribution [] = Just 0
equalDistribution xs =
  let total = sum xs
      target = total `div` length xs
      isDistributable = total `mod` length xs == 0
  in if isDistributable
     then Just
       $ fromIntegral
       $ sum
       $ map abs
       $ scanl (\a b -> a + b - target) 0 xs
     else Nothing