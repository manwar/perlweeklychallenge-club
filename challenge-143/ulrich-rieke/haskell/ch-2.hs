module Challenge143_2
  where
import Data.List ( subsequences , sort )
import Data.List.Split ( divvy )

findDivisors :: Int -> [Int]
findDivisors n = filter (\i -> mod n i == 0 ) [1 .. n]

combinationsOfTwo :: Int -> [[Int]]
combinationsOfTwo num
  |isSquareNumber num = theList ++ [[root , root]]
  |otherwise = theList
  where
      theList :: [[Int]]
      theList = filter ( (== 2 ) . length ) $ subsequences $ findDivisors num
      root = floor $ sqrt $ fromIntegral num

isSquareNumber :: Int -> Bool
isSquareNumber n = (root * root ) == fromIntegral n
  where
      root = sqrt $ fromIntegral n

findPossibleCombinations :: Int -> [[Int]]
findPossibleCombinations num = filter (\pair -> head pair * last pair == num )
$ combinationsOfTwo num

isStealthy :: Int -> Bool
isStealthy n
  |(length $ combinationsOfTwo n) < 2 = False
  |otherwise = any (\p -> abs ( head p - last p ) == 1 ) $ divvy 2 1 $  sort
    $ map sum $ findPossibleCombinations n

solution :: Int -> Int
solution num
  |isStealthy num = 1
  |otherwise      = 0
