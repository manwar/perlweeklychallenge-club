module Ch2 exposing ( .. )

import Array  as A
import String as S
import Tuple  as Tp
import List   as L
import Maybe  as Mb

combiIndex2 : Int -> List (Int, Int)
combiIndex2 n = L.concat
                (L.map (\x1 ->
                           (L.map (\x2 -> (x1, x2) -- tuple is better choice
                                                   -- it was very hard to access
                                                   -- elements insdide
                                                   -- if a list maded
                                  ) (L.range (x1 + 1) n)))
                     (L.range 0 (n - 1)))

type alias Point  = { col   : Int,   row : Int }
type alias HLine  = { start : Int,   end : Int, row : Int }
type alias Square = { hline : HLine, alsoAtRow : Int }

pointsAtRowsFromString : String -> Result String (List (List Point))
pointsAtRowsFromString input =
    let linesStr = S.concat(S.lines input)
        lines_ = S.split "]" linesStr
        lines  = L.take ((L.length lines_) - 1) lines_ -- ignore last garbage
        -- matrixLines : a string at each row contains only '1' or '0'
        matrixLines = L.filterMap
                       (\ln -> Just (S.filter
                                         (\ch -> case ch of
                                                     '1' -> True
                                                     '0' -> True
                                                     _   -> False) ln))
                       lines
    in if S.isEmpty (S.trim input) then
           Err ""
       else if L.length matrixLines < 2 then
           Err "Number of Rows is too small: need at least 2 or more"
            else Ok
                (L.indexedMap
                     (\ri mln -> -- ri : row index
                          L.filterMap
                          (Mb.map
                               (\ci -> { col = ci, row = ri }))
                          (L.indexedMap
                               (\col ch -> if ch == '1'
                                           then Just col else Nothing )
                               (S.toList mln)))
                     matrixLines)

getHorizLines : List (List Point) -> Result String (List HLine)
getHorizLines ptsAtRows =
    let horizlines_
            = L.concat -- flatten
              (L.indexedMap
                   (\ri pts ->
                        L.map
                        (\cbi ->
                             Mb.map2
                             (\p1 p2 -> { start = p1.col
                                        , end = p2.col
                                        , row = ri} )
                             (A.get (Tp.first  cbi) (A.fromList pts))
                             (A.get (Tp.second cbi) (A.fromList pts))
                        ) (combiIndex2 (L.length pts))
                   ) ptsAtRows)
    in
        Ok (L.filterMap identity horizlines_)

findSquares : List HLine -> Result String (List Square)
findSquares hlines =
    let listLen = L.length hlines in
    Ok (L.filterMap
            identity
            (L.filterMap
                 (\cbi ->
                      Mb.map2
                      (\hl1 hl2 ->
                           if hl1.start == hl2.start &&
                               hl1.end  == hl2.end   &&
                               (hl2.row - hl1.row) ==
                                   (hl1.end - hl1.start) then
                               Just { hline = hl1, alsoAtRow = hl2.row }
                           else Nothing )
                      (A.get (Tp.first  cbi) (A.fromList hlines))  -- type Maybe
                      (A.get (Tp.second cbi) (A.fromList hlines))) -- ditto
                 (combiIndex2 listLen)))
