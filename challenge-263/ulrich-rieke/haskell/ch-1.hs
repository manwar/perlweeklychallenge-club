module Challenge263
   where
import Data.List ( sort ) 

solution :: [Int] -> Int -> [Int]
solution list k = map fst $ filter ((== k ). snd ) $ zip [0,1..] sorted
 where
  sorted :: [Int]
  sorted = sort list

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!"
   numberterms <- getLine
   putStrLn "Enter a target integer!"
   kline <- getLine
   print $ solution ( map read $ words numberterms ) ( read kline )
