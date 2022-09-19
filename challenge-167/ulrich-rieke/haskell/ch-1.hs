module Challenge167
  where

isPrime :: Int -> Bool
isPrime n
  |n == 2 = True
  |n == 1 = False
  |otherwise = null $ filter (\i -> mod n i == 0 ) [2 .. root]
  where
      root :: Int
      root = floor $ sqrt $ fromIntegral n

findCycle :: Int -> [Int]
findCycle n = (takeWhile (/= n ) $ iterate step ( step n )) ++ [n]
where
  step :: Int -> Int
  step d = read ( tail s ++ [head s] )
  where
    s = show d

solution :: [Int]
solution = take 10 $ filter (\i -> (noNull i ) && ( all (\d -> isPrime d
&& d >= i ) $ findCycle i )) [100 , 101 ..]
  where
  noNull :: Int -> Bool
  noNull d = not  ( elem '0' $ show d )
