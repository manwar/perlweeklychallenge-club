module Challenge340_2
   where
import Data.Char ( isDigit ) 
import Data.List.Split( divvy ) 

isValidNumber :: String -> Bool
isValidNumber s = head s /= '0' && all isDigit s

solution :: [String] -> Bool
solution allWords = all (\subli -> (last subli - head subli) > 0 ) $  divvy 2 1 $
 map read $ filter isValidNumber allWords

main :: IO ( ) 
main = do 
   putStrLn "Enter a string with non-digit letters and numbers only!" 
   line <- getLine
   print $ solution $ words line
