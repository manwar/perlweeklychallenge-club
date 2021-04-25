module Nums exposing (..)

import Chowla
import Expect
import Test exposing (..)


suite : Test
suite =
    describe "Chowla numbers"
        [ test "nums 20" <|
            \_ -> Chowla.nums 20 |> Expect.equal [ 0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21 ]
        , test "nums 18" <|
            \_ -> Chowla.nums 18 |> Expect.equal [ 0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20 ]
        , test "nums 6" <|
            \_ -> Chowla.nums 6 |> Expect.equal [ 0, 0, 0, 2, 0, 5 ]
        , test "nums 4" <|
            \_ -> Chowla.nums 4 |> Expect.equal [ 0, 0, 0, 2 ]
        ]
