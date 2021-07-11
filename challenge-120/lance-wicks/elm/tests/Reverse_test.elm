module Reverse_test exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Bit exposing (swap)

import Binary

suite : Test
suite =
    describe "Swap"
      [ describe "Examples"
        [ test "101 -> 154" <|
            \_ -> Expect.equal 154 (swap 101)
          , test "18 -> 33" <|
            \_ -> Expect.equal 33 (swap 18)
        ]

      ]
