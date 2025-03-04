module Challenge311
   where
import Data.Char 

solution :: String -> String
solution = map (\c -> if isUpper c then toLower c else toUpper c )

main :: IO ( )
main = do
   putStrLn "Enter a word consisting of English words only!"
   word <- getLine
   print $ solution word 
