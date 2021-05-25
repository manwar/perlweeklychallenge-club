#!/usr/bin/env runghc

-- run <script> <number>

import System.Environment (getArgs)

doubleUp :: Int -> String -> String
doubleUp nrDigs initHalf = initHalf ++ otherHalf where
  otherHalf = if (odd nrDigs) then (reverse . init $ initHalf) else (reverse initHalf)

nxtPali :: String -> String
nxtPali nrStr
  |nr <= 8 = show (nr + 1)
  |null $ dropWhile ('9'==) nrStr = show (nr + 2)
  |otherwise = if pali > nr then show pali else (doubleUp nrDigs . show . (1+) . (read::String->Int) $ initHalf) where
     nrDigs = length nrStr
     initHalf = take (div (nrDigs+1) 2) nrStr
     pali = (read::String->Int) $ doubleUp nrDigs initHalf
     nr = (read::String->Int) nrStr

main :: IO ()
main = getArgs >>= putStrLn . nxtPali . head
