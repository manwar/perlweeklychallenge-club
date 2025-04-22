module Challenge318
   where
import Data.List ( group )

solution :: String -> [String]
solution word = filter( (>= 3) . length ) $ group word

main :: IO ( )
main = do
   putStrLn "Enter a word!" 
   word <- getLine
   print $ solution word
