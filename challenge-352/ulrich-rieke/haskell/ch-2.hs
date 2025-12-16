module Challenge352_2
   where
import Data.Char ( digitToInt , intToDigit ) 
import Data.List ( inits )
import Data.List.Split ( splitOn )

fromBinaryString :: String -> Int
fromBinaryString binary = 
   let multipliers = take ( length binary ) $ iterate ( * 2 ) 1
       reversed = reverse binary  
   in sum $ zipWith ( * ) ( map digitToInt reversed ) multipliers  

solution :: String -> [Bool]
solution numberstring = 
   let startingZeroes = takeWhile ( == '0' ) numberstring
       firstlen       = length startingZeroes
   in (replicate firstlen True) ++ ( map (\s -> mod ( fromBinaryString s )
    5 == 0 ) $ filter ( not . null ) $ inits $ drop firstlen numberstring )           

main :: IO ( )
main = do
   putStrLn "Enter some 0 and 1 separated by blanks!"
   numberline <- getLine
   print $ solution $ foldl1 ( ++ ) $ splitOn " " numberline
