module Challenge255
   where
import Data.List ( sort ) 

solution :: String -> String -> Char
solution s1 s2 = selectedC
 where
   selected = filter (\c -> notElem c s1 ) s2
   selectedC = if not $ null selected then head selected else head $ filter (\c -> 
    count c s2 /= count c s1 ) s2 
    where
     count :: Char -> String -> Int
     count someChar aString = length $ filter ( (==someChar) ) aString

main :: IO ( )
main = do
   putStrLn "Enter a word!" 
   firstWord <- getLine
   putStrLn "Enter a second word , permuting the first, + 1 character!"
   secondWord <- getLine
   print $ solution firstWord secondWord
