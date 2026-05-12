module Challenge373
   where

solution :: [String] -> [String] -> Bool
solution firstWords secondWords = foldl1 (++ ) firstWords == foldl1 (++ ) secondWords

main :: IO ( )
main = do
   putStrLn "Enter some words separated by blanks!"
   firstLine <- getLine
   putStrLn "Enter some more words separated by blanks!"
   secondLine <- getLine
   print $ solution ( words firstLine ) ( words secondLine )
