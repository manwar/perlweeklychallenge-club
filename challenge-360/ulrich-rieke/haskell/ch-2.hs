module Challenge360_2
   where
import Data.Char ( toLower )
import Data.List ( sortOn )

solution :: String -> String
solution input = unwords $ sortOn ( map toLower ) $ words input

main :: IO ( )
main = do
   putStrLn "Enter a sentence!"
   line <- getLine
   print $ solution line
