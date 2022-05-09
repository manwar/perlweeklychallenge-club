module Challenge163_2
  where

solution :: [Int] -> Int
solution list = head $ until ( (== 1 ) . length ) step list
where
  step :: [Int] -> [Int]
  step start = map (\i -> sum $ take i $ tail start ) [1 .. length $ tail start]
