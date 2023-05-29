module Challenge218
  where
import Data.List ( (!!) )

combi_of_three :: [Int] -> [[Int]]
combi_of_three list = [[list !! i , list !! j , list !! k] | i <- [0..l - 3] ,
j <- [i + 1..l - 2] , k <- [j + 1..l - 1]]
where
  l :: Int
  l = length list

solution :: [Int] -> Int
solution list
  |length list == 3 = product list
  |otherwise = maximum $ map product $ combi_of_three list

main :: IO ( )
main = do
  putStrLn "Enter at least 3 integers, separated by blanks!"
  numberstring <- getLine
  let numbers = map read $ words numberstring
  print $ solution numbers
