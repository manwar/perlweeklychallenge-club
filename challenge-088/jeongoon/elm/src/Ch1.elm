module Ch1 exposing (..)

import List as L

errEmptyList     = "Empty List"
errSomeIsNotPostive = "Some of Element is not Postive Interger"

arrayOfProduct : List Int -> Result String (List Int)
arrayOfProduct ints =
    let len = (L.length ints)
    in
        case len of
             0 -> Err errEmptyList
             1 -> Ok [1] -- not in the spec; probably correct answer
             _ -> if (L.any (\x -> x < 1) ints) == True then
                      Err errSomeIsNotPostive
                  else let p = L.foldr (*) 1 ints
                       in Ok (L.map (\x -> p // x) ints) -- // -> int div.
