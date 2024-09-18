module Challenge287
   where
import Data.Char ( isUpper , isLower , isDigit ) 
import Data.List ( group ) 

solution :: String -> Int
solution word = subterm1 + subterm2 + subterm3 + subterm4 + subterm5
   where
    l        :: Int
    l        = length word
    subterm1 :: Int
    subterm1 = if l < 6 then 6 - l else 0
    subterm2 :: Int
    subterm2 = if (length $ filter isLower word) < 1
               then if l >= 6 then 1 else 0
               else 0
    subterm3 :: Int
    subterm3 = if (length $ filter isUpper word) < 1
               then if l >= 6 then 1 else 0
               else 0
    subterm4 :: Int
    subterm4 = if (length $ filter isDigit word) < 1
               then if l >= 6 then 1 else 0
               else 0
    subterm5 :: Int -- count the number of identical neighbouring letters
    subterm5 = sum $ map (\li -> div ( length li ) 3 ) $ group word 

main :: IO ( )
main = do
   putStrLn "Enter a password!"
   password <- getLine
   print $ solution password
