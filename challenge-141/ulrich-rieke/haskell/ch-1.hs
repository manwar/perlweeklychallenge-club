module Challenge141
  where

findDivisors :: Int -> [ Int ]
findDivisors n = filter (\i -> mod n i == 0 ) [1 .. n]

solution :: [Int]
solution = take 10 $ filter ( ( == 8 ) . length . findDivisors ) [1 .. ]
