#!/usr/bin/env runghc

-- run <script>

import System.Environment (getArgs)

binSearch :: Int -> [Int] -> Int
binSearch = binSearchOffset 0

binSearchOffset :: Int -> Int -> [Int] -> Int
binSearchOffset offset needle xs
  |null xs = -1
  |length xs == 1 = if needle == head xs then offset else -1
  | needle == xs !! mid = offset+mid
  |otherwise = if needle < xs !! mid then binSearchOffset offset needle low else binSearchOffset (offset+mid+1) needle high where
     mid = div (length xs) 2
     low = take mid xs
     high = drop (mid+1) xs

pprnt :: [Int] -> Int -> String
pprnt xs needle = "Found " ++ (show needle) ++ "?\n" ++ (show zero1) where
  zero1 = if binSearch needle xs < 0 then 0 else 1

inArr :: [[Int]]
inArr = [
  [  1,  2,  3,  5,  7 ],
    [  9, 11, 15, 19, 20 ],
    [ 23, 24, 25, 29, 31 ],
    [ 32, 33, 39, 40, 42 ],
    [ 45, 47, 48, 49, 50 ]
  ]

toSearch :: [Int]
toSearch = [1,35,39,100]

main = do
  putStrLn "Array:"
  putStrLn . unlines . map unwords . (map.map) show $ inArr  
  putStrLn . unlines . map (pprnt (concat inArr)) $ toSearch
