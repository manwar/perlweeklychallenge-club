module Chowla exposing (chowla, n, nums)

import List


nums : Int -> List Int
nums max =
    List.range 1 max
        |> List.map n


n : Int -> Int
n num =
    let
        denominators =
            List.range 2 (num - 1)

        numbers =
            List.map (chowla num) denominators
    in
    List.foldl (+) 0 numbers


chowla : Int -> Int -> Int
chowla num denom =
    case remainderBy denom num of
        0 ->
            denom

        _ ->
            0
