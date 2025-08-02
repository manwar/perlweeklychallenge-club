module Challenge282
   where
import Data.List.Split ( divvy )
import Data.Char ( digitToInt )
import Data.List ( group ) 

solution :: String -> Int
solution s = if null grouped then -1 else digitToInt $ head $ head grouped
 where
  grouped = filter (\gr -> length gr == 3 ) $ group s

main :: IO ( )
main = do
   putStrLn "Enter a string consisting of digits only!"
   numberstring <- getLine
   print $ solution numberstring
