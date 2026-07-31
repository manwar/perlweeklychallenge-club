module Challenge383_2
   where
import Data.Char ( intToDigit ) 
import Data.List.Split ( chunksOf ) 
import Data.List ( tail , sortOn) 
import Data.Maybe ( fromJust ) 

websafes :: [(String , Int)]
websafes = [("00" , 0) , ("33" , 51) , ("66" , 102) , ("99" , 153 ) , 
         ("CC" , 204) , ("FF" , 255)]

createConversion :: [(Char , Int)]   
createConversion =
   let smallDigits = [0, 1..9]
       doubleDigits = [10, 11..15]
       helper = "ABCDEF"
   in (zip ( map intToDigit smallDigits ) smallDigits ) ++ ( zip helper 
         doubleDigits )

hexToInt :: String -> Int
hexToInt str = (fromJust $ lookup ( head str ) createConversion) * 16 +
 ( fromJust $ lookup ( last str ) createConversion ) 

roundRGB :: String -> String
roundRGB color =
   let hex_to_values = map (\p -> (snd p , fst p )) websafes
       singleColors = chunksOf 2 $ tail color
       currentValues = map hexToInt singleColors
       selected = map (\n -> findValue ( map snd websafes ) n ) currentValues
   in "#" ++ ( foldl1 ( ++ ) $ map (\n -> fromJust $ lookup n hex_to_values)
         selected )     
       
findValue :: [Int] -> Int -> Int
findValue list number = head $ sortOn (\n -> abs( n - number )) list

main :: IO ( ) 
main = do
   putStrLn "Enter a RGB color!"
   colorline <- getLine
   print $ roundRGB colorline
