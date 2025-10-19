module Challenge342
   where
import Data.List ( sort )
import Data.Char ( isDigit )

separate :: String -> (String , String)
separate str = ( sort $ filter isDigit str , sort $ filter ( not . isDigit ) str ) 

solution :: String -> String
solution str 
   |abs( letterlen - digitlen) > 1 = ""
   |digitlen - letterlen == 1 = (foldl1 (++ ) $ map (\p -> [fst p] ++ [snd p] ) $ zip digits letters) ++
     [last digits]
   |digitlen == letterlen = foldl1 ( ++ ) $ map (\p -> [fst p] ++ [snd p]) $ zip digits letters
   |letterlen - digitlen == 1 = (foldl1	(++) $ map (\p -> [fst p] ++ [snd p]) $ zip letters digits) ++
     [last letters]
       where 
	 (digits , letters) = separate str
	 digitlen           = length digits
	 letterlen          = length letters

main :: IO ( )
main = do
   putStrLn "Enter a string with lowercase English letters and digits only!" 
   word <- getLine
   print $ solution word 
