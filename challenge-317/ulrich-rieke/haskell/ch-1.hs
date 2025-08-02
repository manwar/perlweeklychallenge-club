module Challenge317
   where

solution :: [String] -> String -> Bool
solution strings comparison = (foldl1 (++) $ map (\s -> [head s]) strings) ==
 comparison

main :: IO ( ) 
main = do
   putStrLn "Enter some words separated by whitespace!"
   wordline <- getLine
   putStrLn "Enter another word!"
   comparison <- getLine
   print $ solution ( words wordline ) comparison
