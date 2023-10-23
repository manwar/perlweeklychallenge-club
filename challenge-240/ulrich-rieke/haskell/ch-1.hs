module Challenge240
   where
import Data.Char ( toLower )

findAcronym :: String -> String
findAcronym = map ( toLower . head ) . words

main :: IO ( )
main = do
   putStrLn "Please enter some words, separated by blanks!"
   myLine <- getLine
   putStrLn "Enter a check string!" 
   checkstr <- getLine
   let acronym = findAcronym myLine
   print ( acronym == checkstr )
