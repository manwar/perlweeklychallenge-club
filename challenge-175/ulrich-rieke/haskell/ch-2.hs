module Challenge175_2
  where

chi :: Int -> Int
chi n = length $ filter (\i -> gcd i n == 1 ) [1 .. n - 1]

isPerfectTotient :: Int -> Bool
isPerfectTotient n = (sum $ tail $ until ( (== 1 ) . last ) step [n]) == n
where
  step :: [Int] -> [Int]
  step list = list ++ [ chi $ last list]

solution :: [Int]
solution = take 20 $ filter isPerfectTotient [1 , 2 ..]
