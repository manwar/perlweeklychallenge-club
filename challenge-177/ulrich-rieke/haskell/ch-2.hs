module Challenge177_2
  where

isPrime :: Int -> Bool
isPrime n
  |n == 0 = False
  |n == 1 = False
  |n == 2 = True
  |otherwise = null $ filter (\i -> mod n i == 0 ) [2 .. root]
  where
      root :: Int
      root = round $ sqrt $ fromIntegral n

count :: Eq a => a -> [a] -> Int
count n list = length $ filter ( == n ) list

isPaliCyclops :: Int -> Bool
isPaliCyclops n = and [ isPrime n , odd l , count '0' s == 1 ,
s == reverse s , (s !! ( div l 2 )) == '0' ]
  where
  s = show n
  l = length s

solution :: [Int]
solution = take 20 $ filter isPaliCyclops [100 , 101 ..]
