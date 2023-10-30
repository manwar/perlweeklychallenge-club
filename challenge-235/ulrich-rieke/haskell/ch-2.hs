module Challenge235_2
   where

solution :: [Int] -> [Int]
solution numbers = take ( length numbers ) $ concat $ map (\n -> if n /= 0 then [n]
 else replicate 2 n ) numbers

main :: IO ( ) 
main = do
   putStrLn "Enter some integers, separated by spaces!" 
   numberstrings <- getLine
   print $ solution $ map read $ words numberstrings
