module Challenge323
   where
import Data.List ( isInfixOf  )


solution :: [String] -> Int
solution strings = pluses - minuses 
   where
    pluses :: Int
    pluses = length $ filter (isInfixOf "++" ) strings
    minuses :: Int
    minuses = length $ filter (isInfixOf "--" ) strings

main :: IO ( ) 
main = do
   putStrLn "Enter some operations separated by blanks!"
   opline <- getLine
   print $ solution $ words opline
