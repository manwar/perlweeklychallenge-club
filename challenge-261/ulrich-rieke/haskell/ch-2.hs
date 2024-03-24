module Challenge261_2
   where

solution :: [Int] -> Int -> Int
solution list start = until (\n -> not $ elem n list ) (* 2 ) start

main :: IO ( )
main = do 
   putStrLn "Enter some numbers, separated by blanks!"
   numberstrings <- getLine
   putStrLn "Enter a start number!"
   startline <- getLine
   print $ solution ( map read $ words numberstrings ) ( read startline )
