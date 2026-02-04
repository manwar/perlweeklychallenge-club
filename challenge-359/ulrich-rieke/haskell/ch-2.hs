module Challenge359_2
   where
import Data.List ( group ) 

condition :: String -> Bool
condition str = null grouped || all ( (== 1) . length ) grouped
   where
      grouped = group str

solution :: String -> String
solution str = until condition step str
   where
      step :: String -> String
      step aString = concat $ filter ( (== 1) . length ) grouped 
         where
            grouped :: [[Char]]
            grouped = group aString

main :: IO ( )
main = do
   putStrLn "Enter a string with alphabetic characters only!"
   string <- getLine
   print $ solution string
