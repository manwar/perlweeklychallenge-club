module Challenge254_2
   where
import Data.Char( toUpper , toLower )
import Data.Maybe ( fromJust ) 

vowels :: String
vowels = "aeiouAEIOU"

solution :: String -> String
solution str =  map (\p -> if ( fst p ) == 0 then toUpper $ snd p 
 else toLower $ snd p ) indexed       
 where 
  vowelsContained :: String
  vowelsContained = filter (\c -> elem c vowels ) str
  reversed :: [(Char , Char)]
  reversed = zip vowelsContained ( reverse vowelsContained )
  indexed :: [(Int, Char)]
  indexed = map (\(n , c) -> if elem c vowels then ( n , fromJust $ 
   lookup c reversed ) else ( n , c )) $ zip [0,1..] str

main :: IO ( )
main = do
   putStrLn "Please enter a word!"
   word <- getLine
   print $ solution word
