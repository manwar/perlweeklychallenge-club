module Challenge228
   where

count :: Eq a => [a] -> a -> Int
count list element = length $ filter ( == element ) list

solution :: [Int] -> Int
solution list = sum $ filter ( (== 1 ) . count list ) list 
