module Challenge381_2
   where

solution :: [Int] -> Int
solution numbers = if length numbers < 3 then 0 else length $ filter (\n -> (any ( < n)
 numbers) && (any ( > n ) numbers)) numbers

main :: IO ( ) 
main = do
   putStrLn "Enter some numbers separated by blanks!"
   line <- getLine
   print $ solution $ map read $ words line
