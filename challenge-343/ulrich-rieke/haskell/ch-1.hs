module Challenge343
   where

solution :: [Int] -> Int
solution = minimum . map abs

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline

