module Challenge341
   where
import Data.List ( findIndices )

condition :: String -> String -> Bool
condition str forbidden = all (\l -> null $ findIndices ( == l ) forbidden ) str

main :: IO ( )
main = do
   putStrLn "Enter a line with words consisting of English letters only!"
   allWords <- getLine
   putStrLn "Enter a line with letters separated by whitespace!" 
   letterLine <- getLine
   let letters = map head $ words letterLine
   print $ length $ filter ( flip condition letters ) $ words allWords      
