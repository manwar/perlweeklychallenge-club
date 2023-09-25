module Challenge235
   where
import Data.List.Split ( divvy )

solution :: [Int] -> Bool
solution numbers = (length $ filter (\subli -> last subli > head subli ) pairs) ==
 pairlength - 1 
 where
  pairs = divvy 2 1 numbers
  pairlength = length pairs

main :: IO ( )
main = do
   putStrLn "Enter some integers, separated by blanks!"
   numberstrings <- getLine
   let numbers = map read $ words numberstrings
   if solution numbers then putStrLn "true" else putStrLn "false"
