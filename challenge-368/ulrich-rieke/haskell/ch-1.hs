module Challenge368
   where
import Data.List ( findIndices , tail , (!!) )

change :: String -> Char -> String
change numberstring numchar 
   |head numberstring == numchar && numchar < numberstring !! 1 = tail
    numberstring
   |otherwise = if null found then numberstring else take l numberstring ++ 
    drop ( l + 1 ) numberstring
     where
      found :: [Int]
      found = findIndices ( == numchar ) numberstring
      l     :: Int
      l     = last found

main :: IO ( )
main = do
   putStrLn "Enter a number string!"
   numberstring <- getLine
   putStrLn "Enter a number character!"
   charline <- getLine
   print $ change numberstring ( head charline )
