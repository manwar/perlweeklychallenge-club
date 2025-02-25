module Challenge304_2
   where
import Data.List.Split( divvy ) 

solution :: [Int] -> Int -> Double
solution list len = maximum $ map findAverage $ divvy len 1 list
 where
  findAverage :: [Int] -> Double
  findAverage someList = (fromIntegral $ sum someList) / ( fromIntegral
   $ length someList )

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by blanks!" ;
   numberline <- getLine
   putStrLn "Enter a number less than or equal the length of the array!"
   len <- getLine
   print $ solution ( map read $ words numberline ) ( read len )
