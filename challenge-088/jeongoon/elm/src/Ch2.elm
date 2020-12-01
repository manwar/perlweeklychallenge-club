module Ch2 exposing (..)

import List   as L
import String as S
import Array  as A
import Result as R

errEmptyMatrix = "Matrix is Empty"

parseMatrix : String -> Result String (List (List String))
parseMatrix str =
    let parsed =  str   -- Elm's nice syntax: read from top to bottom
               |> S.split "]"
               |> S.join "\n"
               |> S.lines
               |> L.map (S.replace "[" ""
                             >> S.words >> L.filter (S.isEmpty >> not))
               |> L.filter (L.isEmpty >> not)
    in if L.isEmpty parsed
        || (case L.head parsed of
               Nothing -> True
               Just fr -> L.isEmpty fr) then
           Err errEmptyMatrix
       else
           Ok  parsed

getSpiralArray_ : (List (List String)) -> Int -> Int -> Int -> List String
getSpiralArray_ mat nr nc o = -- number of rows, number of column
    let re = o + nr - 1 -- abs index number of row end
        ce = o + nc - 1 -- abs index number of column end
        north = case (L.drop o >> L.head) mat of
                    Nothing -> []
                    Just rw -> (L.take (o+nc) >> L.drop o) rw
        east  = if nr <= 1 then []
                else mat
                    |> L.drop (o+1)
                    |> L.take (nr-1)
                    |> L.filterMap (L.drop ce >> L.head)
        south = {-if L.isEmpty east then []
                else-}
                if nc <= 1 then []
                else case (L.drop re >> L.head) mat of
                         Nothing -> []
                         Just rw -> rw |> L.reverse
                                 |> L.drop (o+1) |> L.take (nc-1)
        west  = {-if L.isEmpty south then []
                else-}
                if nr <= 2 then []
                else mat
                    |> L.drop (o+1)
                    |> L.take (nr-2)
                    |> L.reverse
                    |> L.filterMap (L.drop o >> L.head)

        nr2   = nr - 2
        nc2   = nc - 2

    in ( if re < 0 || ce < 0 then []
         else north :: if L.isEmpty east then []
                       else east :: if L.isEmpty south then []
                                    else south :: if L.isEmpty west then []
                                                  else west
                                                      :: [ getSpiralArray_
                                                               mat nr2 nc2 (o+1) ] )
        |> L.concat

getSpiralArray : (List (List String)) -> List String
getSpiralArray mat =
    let nr = L.length mat
        nc = case L.head mat of
                 Nothing -> -1
                 Just rw -> L.length rw
    in  if nr > 0 && nc > 0 then getSpiralArray_ mat nr nc 0
        else []

getSpiralArrayFromString : String -> Result String (List String)
getSpiralArrayFromString str =
    str |> parseMatrix
        |> R.map getSpiralArray
