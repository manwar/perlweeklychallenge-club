module Challenge352
   where
import Data.List ( nub , isInfixOf )

solution :: [String] -> [String]
solution input = nub $ filter (\w -> any (\s -> w /= s && w `isInfixOf` s ) input)
 input    

main :: IO ( )
main = do
   putStrLn "Enter some words separated by blanks!" 
   allWords <- getLine
   print $ solution $ words allWords
