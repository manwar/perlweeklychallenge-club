module Challenge277
   where
import Data.List ( intersect )

count :: Eq a => a -> [a] -> Int
count _ [] = 0 
count d (x:xs) 
   |d == x = 1 + count d xs
   |otherwise = count d xs

solution :: [String] -> [String] -> Int
solution firstWords secondWords = length $ filter (\s -> count s firstWords ==
 1 && ( count s secondWords == 1 ) ) $ intersect firstWords secondWords

main :: IO ( )
main = do
   putStrLn "Enter some words separated by blanks!"
   firstWords <- getLine
   putStrLn "Enter some more words separated by blanks!" 
   secondWords <- getLine
   print $ solution ( words firstWords ) ( words secondWords )

