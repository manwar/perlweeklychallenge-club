module JCombinations
  ( combinationsIndex
  ) where

combinationsIndex :: Int -> Int -> [[Int]]
combinationsIndex n m -- return always sorted members and sorted list
  | m < n = []
  | otherwise =
    --       acc         room               nextId to move
    impli [[0 .. (n-1)]] (replicate n (m-n)) (n-1)
    where
      incrAt idx list = take idx list
                        ++ ((list !! idx) +1) : drop (idx+1) list
      dcrAt idx list  = take idx list
                        ++ ((list !! idx) -1) : drop (idx+1) list
      impli acc roomLs nextCsr =
        if roomLs !! nextCsr > 0 -- still current cursor is movable
        then impli (acc ++ [newPosLs]) (dcrAt nextCsr roomLs) nextCsr
        else -- no more room to move
          -- find the next element available to move
          case (pointNextCsr nextCsr) of
            Nothing    -> acc  -- if we cannot move any of them which means
                              -- we found all cases.
            Just newCsr ->     -- move all cursors
                              -- and try to move last cursor next time
              impli ( acc ++ [updatePosLsFrom newCsr] )
                    (updateRoomFrom newCsr) (n-1)
          where
            posLs    = last acc
            newPosLs = (incrAt nextCsr posLs)

            updatePosLsFrom fromCsr = -- move all cursors
              take (fromCsr) posLs    -- keep until fromCsr
              -- and reset others to leftmost part of the elements
              ++ take (n -fromCsr) [ ((posLs !! fromCsr)+1) .. ]
            updateRoomFrom fromCsr =
              take (fromCsr) roomLs
              -- reduce each room by one
              ++ replicate (n -fromCsr) ((roomLs !! fromCsr) -1)

            pointNextCsr curcsr
              | curcsr == 0 = Nothing
              | otherwise  = if roomLs !! nxtcsr > 0 then Just nxtcsr
                             else pointNextCsr nxtcsr
              where nxtcsr = curcsr - 1
