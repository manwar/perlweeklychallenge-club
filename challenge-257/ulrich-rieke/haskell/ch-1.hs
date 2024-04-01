module Challenge257
   where

solution :: [Int] -> [Int]
solution list = map (\i -> length $ filter ( < i ) list ) list

main :: IO ( )
main = do
   putStrLn "Enter some integers, separated by blanks!"
   numbers <- getLine
   print $ solution $ map read $ words numbers
