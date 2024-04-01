module Challenge262
   where

solution :: [Int] -> Int
solution list = max positives negatives
 where
  positives :: Int
  positives = length $ filter ( > 0 ) list
  negatives :: Int
  negatives = length $ filter ( < 0 ) list

main :: IO ( )
main = do
   putStrLn "Enter some integers, separated by whitespace!" 
   numberline <- getLine
   print $ solution ( map read $ words numberline )
