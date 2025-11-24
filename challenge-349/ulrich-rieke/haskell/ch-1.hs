module Challenge349
   where
import Data.List ( sortOn , group) 

solution :: String -> Int
solution = length . last . sortOn length . group

main :: IO ( ) 
main = do
   putStrLn "Enter a word!"
   word <- getLine
   print $ solution word
