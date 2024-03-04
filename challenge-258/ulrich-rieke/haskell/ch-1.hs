module Challenge258
   where

solution :: String -> Int
solution = length . filter even . map length . words

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by spaces!" 
   numbers <- getLine
   print $ solution numbers 
