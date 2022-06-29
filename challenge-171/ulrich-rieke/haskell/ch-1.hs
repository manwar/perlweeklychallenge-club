module Challenge171
  where

findDivisors :: Int -> [Int]
findDivisors n = [d | d <- [1 .. div n 2] , mod n d == 0]

isAbundant :: Int -> Bool
isAbundant n = (sum $ findDivisors n) > n

solution :: [Int]
solution = take 20 $ filter isAbundant $ enumFromThen 3 5
