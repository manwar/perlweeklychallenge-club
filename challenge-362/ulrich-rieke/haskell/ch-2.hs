module Challenge362_2
   where
import Data.List ( sortOn )
import Data.Maybe ( fromJust ) 

toNumberString :: Int -> String
toNumberString n 
   |l == 1 = fromJust $ lookup n conversions
   |l == 2 = if mod n 10 == 0 then fromJust $ lookup n conversions else (fromJust $ lookup
              ( div n 10 ) conversions) ++ "-" ++ (fromJust $ lookup ( mod n 10 ) conversions)
   |l == 3 = if mod n 100 == 0 then (fromJust $ lookup ( div n 100 ) conversions) ++ 
              " hundred" else (fromJust $ lookup ( div n 100 ) conversions) ++ " hundred and "
              ++ (toNumberString ( mod n 100 ))
   |l > 3 && l < 7 = if mod n 1000 == 0 then toNumberString ( div n 1000 ) ++ " thousand" 
                      else toNumberString ( div n 1000 ) ++ " thousand " ++ 
                       toNumberString ( mod n 1000 )
   |l > 6 && l < 10 = if mod n 1000000 == 0 then toNumberString( div n 1000000 ) ++ 
                       " million" else toNumberString ( div n 1000000 ) ++ " million "
                        ++ toNumberString ( mod n 1000000 ) 
   |l > 9 && l < 13 = if mod n 1000000000 == 0 then (toNumberString $ div n 1000000000 ) ++
                       " billion" else ( toNumberString $ div n 1000000000 ) ++ " billion " ++ 
                        (toNumberString $ mod n 1000000000) 
   |otherwise       = "We don't want to exaggerate the game..."
    where
      l :: Int
      l = length $ show n

conversions :: [(Int , String)]
conversions = zip numbers strings
   where
      numbers :: [Int]
      numbers = [0 , 1 ..20] ++ [30 , 40 .. 90]
      strings :: [String]
      strings = ["zero" , "one" , "two" , "three" , "four" , "five" , "six" , "seven" , 
                 "eight" , "nine" , "ten" , "eleven" , "twelve" , "thirteen" , 
                 "fourteen" , "fifteen" , "sixteen" , "seventeen" , "eighteen" , 
                 "nineteen" , "twenty" , "thirty" , "forty" , "fifty" , "sixty" , 
                 "seventy" , "eighty" , "ninety"] 

finalConvert :: Int -> String
finalConvert number = if number < 0 then "minus " ++ (toNumberString $ abs number) else 
 toNumberString number

main :: IO ( )
main = do
   putStrLn "Enter some numbers separated by whitespace!"
   numberline <- getLine
   let numbers = map read $ words numberline :: [Int]
   print $ sortOn finalConvert numbers 
