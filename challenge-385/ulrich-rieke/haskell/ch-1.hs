module Challenge385
   where
import Data.List ( group , sort )

solution :: String -> String -> [String]
solution firstline secondline = 
   let firstwords = words firstline
       secondwords = words secondline
       ordered = group $ sort (firstwords ++ secondwords)
   in map head $ filter ((== 1) . length ) ordered

main :: IO ( ) 
main = do
   putStrLn "Enter some strings!"
   firstline <- getLine
   putStrLn "Enter some more strings!"
   secondline <- getLine
   print $ solution firstline secondline
