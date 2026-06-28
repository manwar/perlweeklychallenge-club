module Challenge379
   where
import Data.List ((!!))

strangeReverse :: String -> String
strangeReverse str = [str !! i | i <- [l - 1, l - 2 ..0]]
   where
      l = length str

main :: IO ( ) 
main = do
   putStrLn "Enter a string!"
   myString <- getLine
   if length myString == 0 then print "" else print $ strangeReverse myString
