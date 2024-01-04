module Challenge250
   where

solution :: [Int] -> Int
solution list = if null selected then -1 else minimum selected
 where
  selected = map fst $ filter (\p -> fst p `mod` 10 == snd p ) $ zip [0..] list

