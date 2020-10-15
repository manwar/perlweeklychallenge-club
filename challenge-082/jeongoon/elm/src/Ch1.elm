module Ch1 exposing ( getCommonFactors )

import String as S
import List   as L
import Maybe  as Mb

getCommonFactors : Int -> Int ->  Result String (List Int)
getCommonFactors m n =
    if L.all (\x -> x < 0 ) [m, n]
    then Err "" -- probably initial state or equivalent to.
    else if L.any(\x -> x < 1) [m, n]
         then Err "Please input all the strings !!!"
         else
             case commonFactors [m, n] of
                 [] -> Err "invalid input"
                 ls -> Ok ls

commonFactors : List Int -> List Int
commonFactors ils =
    case ils of
        []  -> []
        ls  ->
            let l = L.minimum ls
                g = L.maximum ls in
            case Mb.map2 (\a b -> a == b) l g of
                Nothing   -> []
                Just same ->
                    case l of
                        Nothing -> [] -- impossible but have to
                        Just jl ->
                            if same then
                                -- note: modBy has opposite order of arguments
                                -- when compared to most of other language
                                L.filter (\dv -> modBy dv jl ==0) (L.range 1 jl)
                            else
                                L.filter (\dv ->
                                              L.all (\i ->
                                                         modBy dv i == 0) ls)
                                    (L.range 1 jl)
