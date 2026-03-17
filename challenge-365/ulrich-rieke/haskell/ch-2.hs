module Challenge365_2
   where
import Data.Char ( isDigit , isLower) 
import Data.List (findIndex ,  findIndices , (!!) ) 

hyphens :: String -> Bool
hyphens str = case findIndex ( == '-' ) str of
   Just pos -> ((length $ findIndices ( == '-' ) str) == 1) && (pos /= length str - 1) 
    && (isLower ( str !! (pos - 1 ) )) && (isLower ( str !! ( pos + 1 ) )) 
   Nothing -> True

puncts :: String -> Bool
puncts str = case findIndex ( flip elem "!,." ) str of
   Just pos -> pos == ( length str - 1 )
   Nothing -> True

letters :: String -> Bool
letters = all ( not . isDigit )

isValid :: String -> Bool
isValid str = and [letters str , puncts str , hyphens str]

main :: IO ( )
main = do
   putStrLn "Enter a sentence!" 
   sentence <- getLine
   print $ length $ filter isValid $ words sentence
