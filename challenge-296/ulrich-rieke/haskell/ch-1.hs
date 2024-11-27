module Challenge296
   where
import Data.List ( group , (!!) , findIndices)
import Data.Char ( isDigit )   

compress :: String -> String
compress str = foldl1 ( ++ ) $ map (\p -> if fst p == 1 then [snd p] else (show
 ( fst p ) ++ [snd p] ) ) $ map (\subli -> (length subli , head subli ))
  $ group str

decompress :: String -> String
decompress str = 
   let numbers = findIndices isDigit str
   in foldl1 ( ++ ) $ map (\i -> if elem i numbers then replicate i
    ( str !! ( i + 1 ) ) else [str !! i] ) [0..length str - 1]	 
   
main :: IO ( )
main = do
   putStrLn "Enter a word!" 
   word <- getLine 
   let compressed = compress word
       decompressed = decompress compressed 
   putStr "word compressed :"  
   putStrLn compressed 
   putStr "and now decompressed: "
   putStrLn decompressed 
