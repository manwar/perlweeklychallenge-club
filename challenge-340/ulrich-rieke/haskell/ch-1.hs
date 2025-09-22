module Challenge340
   where
import Data.List.Split ( divvy ) 
import Data.List ( group ) 

noDoubles :: String -> Bool  
noDoubles = all (\subli -> head subli /= last subli ) . divvy 2 1

excludeDouble :: String -> String
excludeDouble s = 
   let grouped = group s
       filtered = filter ((== 1) . length ) grouped 
   in if null filtered then "" else foldl1 (++) $ filter ((== 1) . length) grouped

solution :: String -> String
solution s = until noDoubles excludeDouble s

main :: IO ( )
main = do
   putStrLn "Enter a string!"
   word <- getLine
   print $ solution word

