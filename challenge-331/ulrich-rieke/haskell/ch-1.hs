module Challenge331
   where
import Data.List.Split ( splitWhen )
import Data.Char ( isSpace , isAlphaNum) 

solution :: String -> Int
solution =  length . last . filter (\s -> all isAlphaNum s ) .
 filter ( not . null )  . splitWhen isSpace


main :: IO ( )
main = do  
   putStrLn "Enter a string!"
   line <- getLine
   print $ solution line
