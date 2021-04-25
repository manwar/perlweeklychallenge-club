module N exposing (..)

import Chowla
import Expect
import Test exposing (..)


suite : Test
suite =
    describe "Chowla number"
        [ test "n 1" <|
            \_ -> Chowla.n 1 |> Expect.equal 0
        , test "n 4" <|
            \_ -> Chowla.n 4 |> Expect.equal 2
        , test "n 6" <|
            \_ -> Chowla.n 6 |> Expect.equal 5
        ]


chowla : Test
chowla =
    describe "Chowla number logic"
        [ test "chowla 2 2" <|
            \_ -> Chowla.chowla 2 2 |> Expect.equal 2
        , test "chowla 2 3" <|
            \_ -> Chowla.chowla 2 3 |> Expect.equal 0
        , test "chowla 2 4" <|
            \_ -> Chowla.chowla 2 4 |> Expect.equal 0
        ]


list : Test
list =
    describe "First 20 Chowla numbers"
        [ test "nums 6" <|
            \_ -> Chowla.nums 6 |> Expect.equal [ 0, 0, 0, 2, 0, 5 ]
        , test "nums 22" <|
            \_ -> Chowla.nums 22 |> Expect.equal [ 0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21, 10, 13 ]
        , test "nums 20" <|
            \_ -> Chowla.nums 20 |> Expect.equal [ 0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21 ]
        ]
