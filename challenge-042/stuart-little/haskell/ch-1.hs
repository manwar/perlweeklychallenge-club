#!/usr/bin/env runghc

-- run <script>

convToBase b nr
  |nr < b =[nr]
  |otherwise = (convToBase b high) ++ [low] where
     (high,low) = divMod nr b

main = do
  let l = [1..50]
  mapM_ putStrLn $ map (\(x,y) -> "Decimal: " ++ (show x) ++ " -- Octal: " ++ (concat $ map show y)) $ zip l $ map (convToBase 8) l
