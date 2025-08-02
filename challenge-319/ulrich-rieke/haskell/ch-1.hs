module Challenge319
   where

vowels :: [Char]
vowels = "aeiouAEIOU" 

solution :: [String] -> Int
solution list = length $ filter condition list
   where
    condition :: String -> Bool
    condition s = elem ( head s ) vowels || elem ( last s ) vowels

main :: IO ( )
main = do
   putStrLn "Enter some words separated by whitespace!"
   wordline <- getLine
   print $ solution $ words wordline

