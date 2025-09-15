module Challenge339_2 
   where

solution :: [Int] -> Int
solution list = maximum ( scanl ( + ) 0 list ++ [0] )

main :: IO ( )
main = do
   putStrLn "Enter some height differences separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
