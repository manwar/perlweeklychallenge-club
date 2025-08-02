module Challenge327
   where

solution :: [Int] -> [Int]
solution list = filter (\i -> notElem i list ) [1..length list]

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
