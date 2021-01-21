#!/usr/bin/env runghc

-- run <script>

import Data.List ((\\),group,)
import Data.Matrix (Matrix,submatrix,mapPos,fromLists,toList,getRow,getCol,prettyMatrix,)
import qualified Data.Vector as V (toList,)

bdsMod3 :: Int -> (Int,Int)
bdsMod3 i = (p,p+2) where
  p = 3*(div (i-1) 3) + 1

block33List :: (Int,Int) -> Matrix a -> [a]
block33List (i,j) = toList . (submatrix lowi highi lowj highj) where
  (lowi,highi) = bdsMod3 i
  (lowj,highj) = bdsMod3 j

rowToList :: Int -> Matrix a -> [a]
rowToList i = V.toList . (getRow i)

colToList :: Int -> Matrix a -> [a]
colToList j = V.toList . (getCol j)

possAtPos :: Eq a => [a] -> (Int,Int) -> Matrix a -> [a]
possAtPos alph (i,j) mat = alph \\ (concat [(block33List (i,j) mat),(rowToList i mat),(colToList j mat)])

nextPoss :: Eq a => [a] -> Matrix a -> Matrix [a]
nextPoss alph mat = mapPos (\(i,j) a -> possAtPos alph (i,j) mat) mat

iter1 :: Eq a => [a] -> Matrix a -> Matrix a
iter1 alph mat = mapPos (
  \pos a -> let possibilities = possAtPos alph pos mat in
    if (notElem a alph) && (length possibilities == 1)
            then (head possibilities)
            else a
  ) mat

alph :: String
alph = ['1'..'9']

puzzle :: Matrix Char
puzzle = fromLists [
  "___26_7_1",
  "68__7__9_",
  "19___45__",
  "82_1___4_",
  "__46_29__",
  "_5___3_28",
  "__93___74",
  "_4__5__36",
  "7_3_18___"
  ]

main = do
  let iterations = iterate (iter1 alph) puzzle
  print $ (fst . head) $ dropWhile (\(x,y) -> x /= y) $ zip iterations $ tail iterations
