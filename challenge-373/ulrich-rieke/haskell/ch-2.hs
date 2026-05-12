module Challenge373_2
   where
import Data.List.Split ( chunksOf ) 

solution :: [Int] -> Int -> [[Int]]
solution numbers parts =
   let ( total , remainder ) = quotRem ( length numbers ) parts
   in if remainder == 0 then chunksOf total numbers else (chunksOf ( total + 1 ) $ 
    take ( remainder * ( total + 1 ) ) numbers) ++ ( chunksOf total $ drop ( remainder
      * ( total + 1 ) ) numbers )

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!"
   numberline <- getLine
   putStrLn "Enter a positive integer!"
   num       <- getLine
   let numbers = map read $ words numberline
       number  = (read num :: Int )
   if length numbers < number then print "-1" else print $ solution numbers number
