module Challenge252
   where

solution :: [Int] -> Int
solution list = sum $ map (\p -> snd p ^ 2 ) $ filter (\p -> mod l
 ( fst p + 1 ) == 0 ) $ zip [0 , 1..] list
 where
  l = length list

