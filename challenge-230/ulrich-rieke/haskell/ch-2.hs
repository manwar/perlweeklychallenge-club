module Challenge230_2
   where

import Data.List ( isPrefixOf ) 

solution :: [String] -> String -> Int
solution words prefix = length $ filter (\w  -> prefix `isPrefixOf` w ) 
 words

main :: IO ( ) 
main = do
   putStrLn "Please enter some words, separated by blanks!" ;
   input <- getLine
   putStrLn "Please enter a prefix!" 
   prefix <- getLine
   print $ solution ( words input ) prefix
