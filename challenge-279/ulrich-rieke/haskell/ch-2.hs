module Challenge279_2
   where

solution :: String -> Bool
solution str = ( length $ filter (\c -> elem c "aeiouAEIOU" ) str ) `mod` 2 
 == 0 

main :: IO ( ) 
main = do
   putStrLn "Enter a string!"
   line <- getLine
   print $ solution line
