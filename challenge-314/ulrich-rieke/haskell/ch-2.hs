module Challenge314_2
   where
import Data.List ( transpose , sort ) 

solution :: [String] -> Int
solution list = length $ filter ( not . isSorted ) $ transpose list
 where
  isSorted :: String -> Bool
  isSorted s = s == sort s 

main :: IO ( )
main = do
   putStrLn "Enter some words of equal length separated by blanks!"
   wordline <- getLine
   print $ solution $ words wordline
