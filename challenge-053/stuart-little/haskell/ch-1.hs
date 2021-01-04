#!/usr/bin/env runghc

-- run <script>

import Data.List (transpose,intercalate,)
import Data.List.Split (chunksOf,)

rot90 mat = map reverse $ transpose mat

main = do 
  mapM_ putStrLn $ map (((replicate 40 '-') ++ "\n") ++) $ map (intercalate "\n") $ (map.map) unwords $ take 4 $ iterate rot90 $ (map.map) show $ chunksOf 3 [1..9]
