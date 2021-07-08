module Bit exposing (..)

import Binary

swap num =
          num
            |> Binary.fromDecimal
            |> Binary.ensureSize 8
            |> Binary.chunksOf 2
            |> List.map Binary.toIntegers
            |> List.map List.reverse
            |> List.map Binary.fromIntegers
            |> Binary.concat
            |> Binary.toDecimal

