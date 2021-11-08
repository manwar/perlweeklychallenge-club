#!/usr/bin/env runghc

-- run <script> <number>

import System.Environment (getArgs)

trps :: Int -> [[Int]]
trps n = top ++ mid where
  top = filter (\[x,y,z] -> x>0 && y>0 && x^2+y^2==z^2) [[i,(floor $ sqrt $ fromIntegral (n^2-i^2)),n] | i <- [1..div (n+1) 2]]
  mid = map (\i-> [div ((div (n^2) i)-i) 2, n, div ((div (n^2) i)+i) 2]) $ filter(\i-> mod (n^2) i == 0 && mod i 2 == mod (div (n^2) i) 2) [1..n-1]

main :: IO ()
main = getArgs >>= putStrLn . (\x-> if length x > 0 then x else "-1") . unlines . map unwords . (map.map) show . trps.(read::String->Int).head
