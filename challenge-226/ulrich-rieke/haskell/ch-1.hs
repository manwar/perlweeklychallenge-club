module Challenge226
   where
import Data.List ( sortOn ) 

solution :: String -> [Int] -> String
solution str numbers = map snd $ sortOn fst $ zip numbers str

main :: IO ( )
main = do 
   putStrLn "Enter a string!" 
   str <- getLine 
   putStrLn "Enter some indices into the string, separated by blanks!"
   numberstrings <- getLine
   let numbers = map read $ words numberstrings
   print $ solution str numbers
