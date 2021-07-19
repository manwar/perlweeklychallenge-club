#!/usr/bin/env runghc

-- run <script> <score>

import System.Environment (getArgs)

nextComp :: Int -> [[[Int]]] -> [[[Int]]]
nextComp bd xsss = reverse $ take bd $ it:(reverse xsss) where
  it = concatMap (\(i,xss)-> map (i:) xss) $ zip [1..bd] $ reverse xsss

comp :: Int -> Int -> [[Int]]
comp n bd = last.last $ take n $ tail $ iterate (nextComp bd) [[[]]]

main :: IO ()
main = getArgs >>= putStrLn . unlines . map unwords . (map (map show)) . flip comp 3 . (read::String->Int) . head
  
  
