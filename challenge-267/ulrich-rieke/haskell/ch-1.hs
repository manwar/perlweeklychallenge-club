module Challenge267
   where

solution :: [Int] -> Int
solution list
   |prod > 0 = 1
   |prod == 0 = 0
   |otherwise = -1
   where 
    prod :: Int
    prod = product list

main :: IO ( )
main = do
   putStrLn "Enter some integers, separated by blanks!"
   numberstrings <- getLine
   print $ solution $ map read $ words numberstrings
