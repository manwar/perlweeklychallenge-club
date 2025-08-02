module Challenge278
   where
import Data.Char ( isDigit ) 
import Data.List ( sortOn ) 

solution :: String -> String
solution str = 
   let wordlist = words str
       allPairs = map (\w -> span (\c -> not $ isDigit c) w ) wordlist
       sorted = sortOn (\p -> (read $ snd p :: Int) ) allPairs
       firstWords = map fst sorted
   in unwords firstWords     

main :: IO ( )
main = do
   putStrLn "Enter a line with words ending in numbers!" 
   myLine <- getLine
   print $ solution myLine 
