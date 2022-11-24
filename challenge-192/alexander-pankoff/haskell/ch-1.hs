#!/usr/bin/env stack
{- stack --resolver lts-20.1 runghc --package HUnit -}
module Main where

import           Test.HUnit
import           Data.Bits
import           Data.Word (Word64)

main = runTestTT
  $ TestList
    [ TestCase $ assertEqual "Example 1" 2 (binaryFlip 5)
    , TestCase $ assertEqual "Example 2" 3 (binaryFlip 4)
    , TestCase $ assertEqual "Example 3" 1 (binaryFlip 6)
    , TestCase $ assertEqual "Example [4 ~= 0b111" 0 (binaryFlip 7)]

binaryFlip :: Word64 -> Word64
binaryFlip n = n `xor` shiftR oneBits (countLeadingZeros n)


