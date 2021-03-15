#!/usr/bin/env runghc

-- run <script> <VIN>

import Data.List ((\\))
import System.Environment (getArgs,)

letters :: String
letters = (['0'..'9'] ++ ['A'..'Z']) \\ "IOQ"

values :: [Int]
values = [0..9] ++ [1..8] ++ ([1..9]\\[6,8]) ++ [2..9]

wts :: [Int]
wts = [8,7..2] ++ [10,0] ++ [9,8..2]

checkDig :: String -> Char
checkDig vin = case (traverse (flip lookup (zip letters values)) vin) of
  Nothing -> error "Invalid characters"
  Just vs -> let r = flip mod 11 $ sum $ zipWith (\i v -> (wts !! i) * v) [0..] vs in
    if r<10
    then head $ show r
    else 'X'

validateVin :: String -> String
validateVin vin
  |(length vin /= 17) = error "Must be 17-characters-long"
  |checkDig vin /= vin !! 8 = error "Check-digit does not match"
  |otherwise = "Valid"

main = do
  vin <- getArgs >>= return.head
  putStrLn $ validateVin vin
