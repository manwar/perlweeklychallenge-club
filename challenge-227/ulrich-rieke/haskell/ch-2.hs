module Challenge227_2
   where
import Data.Maybe( isJust , fromJust) 
import Data.List ( sortOn ) 
import Data.List.Split( splitOn )   
import Data.Char ( digitToInt ) 

romanToArabMap :: [(String , Int)]
romanToArabMap = [("M" , 1000) , ("MM" , 2000) , ("MMM" , 3000) , ("C" , 100 ) ,
 ("CC" , 200) , ("CCC" , 300 ) , ( "CD" , 400 ) , ( "D" , 500 ),
 ("DC" , 600 ) , ("DCC" , 700 ) , ("DCCC" , 800 ) , ("CM" , 
 900 ) , ("X" , 10 ) , ("XX" , 20 ) , ("XXX" , 30 ) , 
 ("XL" , 40 ) , ( "L" , 50 ) , ("LX" , 60 ) , ("LXX" , 70 ) ,
 ("LXXX" , 80 ) , ("XC" , 90 ) , ("I" , 1 ) , ("II" , 2 ) , 
 ("III" , 3 ) , ( "IV" , 4 ) , ("V" , 5 ) , ("VI" , 6 ) , 
 ("VII" , 7 ) , ("VIII" , 8 ) , ("IX" , 9 ) ]

arabToRomanMap :: [(Int , String)]
arabToRomanMap = map (\p -> (snd p , fst p ) ) romanToArabMap

--the following function finds the largest start string that can be found in
--romanToArabMap
findLargestRomanStarter :: String -> String
findLargestRomanStarter str = last $ sortOn length $ filter (\substr ->
   isJust $ lookup substr romanToArabMap) $ map (\n -> take n str ) 
   [1..length str ]

--find all substrings that can be found in the mapping of Roman numerals to
--Arab ones
findAllSubstrings :: String -> [String]
findAllSubstrings  str = snd $ until ( null . fst ) step (str , [] )
 where
  step :: (String , [String]) -> (String , [String] )
  step (aWord , aList ) = ( drop ( length theHead ) aWord , aList ++
   [theHead] )
    where 
     theHead :: String
     theHead = findLargestRomanStarter aWord

arabToRoman :: Int -> String
arabToRoman n = foldl1 ( ++ ) $ map (\i -> fromJust $ lookup i
 arabToRomanMap ) $ filter ( /= 0 ) $ zipWith ( * )
 padded [1000 , 100 , 10 , 1]
 where
  padded :: [Int]
  padded = map digitToInt (replicate ( 4 - ( length $ show n ) ) '0'
   ++ show n )

romanToArab :: String -> Int
romanToArab numeral = sum $ map (\str -> fromJust $ lookup str
 romanToArabMap ) $ findAllSubstrings numeral 

evaluate :: String -> String -> String -> String
evaluate firstNumeral operator secondNumeral 
   |operator == "+" = if sum > 3999 then "non potest"
                      else arabToRoman sum
   |operator == "-" = if difference < 0 then "non potest"
                      else if difference == 0 then "nulla" 
		      else arabToRoman difference
   |operator == "/" = if quotient * secondOp /= firstOp
                      then "non potest"
                      else arabToRoman quotient
   |operator == "**" = if potence > 3999 then "non potest"
                       else arabToRoman potence
   |operator == "*" = if product > 3999 then "non potest"
                      else arabToRoman product
    where
     firstOp = romanToArab firstNumeral
     secondOp = romanToArab secondNumeral
     sum      = firstOp + secondOp
     difference = firstOp - secondOp
     product    = firstOp * secondOp
     potence    = firstOp ^ secondOp
     quotient   = firstOp `div` secondOp

main :: IO ( ) 
main = do
   putStrLn "Enter a term with 2 Roman numerals!"
   myTerm <- getLine
   let [firstTerm , operator , secondTerm] = splitOn " " myTerm
       result = evaluate firstTerm operator secondTerm
   putStrLn $ myTerm ++ " = " ++ result    
