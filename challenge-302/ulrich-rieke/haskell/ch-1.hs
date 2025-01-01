module Challenge302
   where
import qualified Data.Set as S
import Data.List ( maximumBy ) 
import Data.Function ( on ) 

count :: Eq a => a -> [a] -> Int
count _ [] = 0 
count d (x:xs) 
   |d == x = 1 + count d xs
   |otherwise = count d xs

condition :: S.Set String -> Int -> Int -> Bool 
condition subset zeroes ones = 
   let list = S.toList subset
       condensed = foldl1 (++) list
       (foundZeroes , foundOnes ) = ( count '0' condensed , count '1' 
	 condensed ) 
   in foundZeroes == zeroes && foundOnes == ones

solution :: [String] -> Int -> Int -> Int
solution binarystrings zeroes ones = 
   let listset = S.fromList binarystrings
       powSet = S.powerSet listset
       realList = filter ( not . null ) $ S.toList powSet 
       selected = filter (\se ->  condition se zeroes ones ) realList
   in length  $ maximumBy( compare `on` length ) selected 

main :: IO ( ) 
main = do
   putStrLn "Enter some binary strings separated by whitespace!"
   binaries <- getLine
   putStrLn "Enter an integer x to denote the number of 0!" 
   xstring <- getLine
   putStrLn "Enter an integer y to denote the number of 1!"
   ystring <- getLine
   print $ solution ( words binaries ) ( read xstring ) ( read ystring )
