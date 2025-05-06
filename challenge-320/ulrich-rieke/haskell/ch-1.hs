module Challenge320
   where

solution :: [Int] -> Int
solution list = if all (== 0) list then 0 else max positives negatives
   where
      positives :: Int
      positives = length $ filter ( > 0 ) list
      negatives :: Int
      negatives = length $ filter ( < 0 ) list

main :: IO ( )
main = do 
   putStrLn "Enter some integers separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
