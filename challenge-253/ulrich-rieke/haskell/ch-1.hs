module Challenge253
   where
import Data.List.Split( splitOn ) 

solution :: String -> String -> [String]
solution line separator = filter ( not . null ) $ concat $ map
 (\w -> splitOn separator w ) $ words line

main :: IO ( )
main = do
   putStrLn "Enter some strings, separated by blanks!" ;
   strings <- getLine 
   putStrLn "Enter a separator!"
   separator <- getLine
   print $ solution strings separator 
