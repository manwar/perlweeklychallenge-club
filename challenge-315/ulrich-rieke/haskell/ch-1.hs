module Challenge315
   where

solution :: [String] -> Char -> [Int]
solution allWords letter = map fst $ filter ((elem letter) . snd ) $ zip [0 , 1 .. ] allWords

main :: IO ( )
main = do
   putStrLn "Enter a sentence!" 
   sentence <- getLine
   putStrLn "Enter a character!"
   character <- getLine
   print $ solution ( words sentence ) ( head character )
