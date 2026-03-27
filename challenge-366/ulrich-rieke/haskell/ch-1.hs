module Challenge366
   where
import Data.List.Split ( splitOn )
import Data.List ( isPrefixOf )

solution :: String -> String -> Int
solution sentence word = 
   let allWords = splitOn " " sentence
   in length $ filter ( flip isPrefixOf word ) allWords

main :: IO ( ) 
main = do
   putStrLn "Enter a sentence with some words!"
   sentence <- getLine
   putStrLn "Enter a word!"
   word <- getLine
   print $ solution sentence word
   
