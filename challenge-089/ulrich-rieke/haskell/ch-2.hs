module Challenge089_2
  where
import Data.List ( (!!) )
import Data.List.Split ( chunksOf )

count :: Eq a => a -> [a] -> Int
count c [] = 0
count d (x:xs)
  |d == x = 1 + count d xs
  |otherwise = count d xs

--find all lists that fulfill the sum conditions, in a list comprehension
possibleLists :: [[Int]]
possibleLists = [[a , b , c , d , e , f , g , h , i] | a <- [1 .. 9] ,
b <- [1 .. 9], c <- [1 .. 9] , d <- [1 .. 9], e <- [1 .. 9] , f <- [1 .. 9],
g <- [1 .. 9], h <- [1 .. 9], i <- [1 .. 9] ,
a + b + c == 15, d + e + f == 15 , g + h + i == 15,
a + d + g == 15 , b + e + h == 15 , c + f + i == 15 , a + e + i == 15 ,
c + e + g == 15]

--in all possible lists find those where every number occurs only once
validLists :: [[Int]]
validLists = filter myCondition possibleLists
  where
    myCondition :: [Int] -> Bool
    myCondition sublist =  all ( 1 == ) $ map (\n -> count n sublist )
      sublist

--convert a row of 3 numbers into a string
convertRow :: [Int] -> String
convertRow row = "[ " ++ (show $ row !! 0 ) ++ " " ++ ( show $ row !! 1 )
++ " " ++ ( show $ row !! 2 ) ++ " ]"

--convert three rows of 3 numbers each into a "magic square"
--first, convert each row to a string, and then print that string
--after the 3rd row of the square add an empty line
printSquare :: [Int] -> IO ( )
printSquare magic = do
  let rows = map convertRow $ chunksOf 3 magic
  mapM_ putStrLn rows
  putStrLn "  "

main :: IO ( )
main = do
  mapM_ printSquare validLists
