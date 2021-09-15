module Challenge130
  where

solution :: [Int] -> Int
solution list = head $ map fst $ filter ( odd . snd ) $ map (\i ->
( i , count i list ) ) list
where
  count :: Int -> [ Int ] -> Int
  count c li = length $ filter ( == c ) li
