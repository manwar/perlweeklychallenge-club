#!/usr/bin/env runghc

-- run <script> <digit>

import System.Environment (getArgs)

lastDigSumm :: Int -> Int -> Int -> Bool
lastDigSumm nr dig nrSummands = (mod (nr - nrSummands * dig) 10 == 0) && (nrSummands * dig <= nr) && (nrSummands * ((dig -1) * 10 + dig) >= nr)

lastDig :: Int -> Int -> Bool
lastDig nr dig = not $ null $ filter (lastDigSumm nr dig) [1..9]

sol :: Int -> Int -> Bool
sol nr dig
  |dig == 0 = (nr >= 101) || (mod nr 10 == 0)
  |otherwise = (nr >= dig*11) || lastDig nr dig

main = do
  [nr,dig] <- getArgs >>= return . map (read::String->Int) . take 2
  putStrLn . show . fromEnum $ sol nr dig
