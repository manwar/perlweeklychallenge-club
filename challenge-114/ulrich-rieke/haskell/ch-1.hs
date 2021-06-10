module Challenge114
  where

solution :: Int -> Int
solution n = head $ dropWhile myCondition [n + 1 , n + 2 ..]
where
  myCondition :: Int -> Bool
  myCondition num = show num /= ( reverse $ show num )
