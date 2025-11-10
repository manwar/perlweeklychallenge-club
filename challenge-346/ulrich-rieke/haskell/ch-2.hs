module Challenge346_2
   where
import Data.List ( findIndex , findIndices , (!!))
import qualified Data.Set as S
import Data.Char ( isDigit ) 
import Data.List.Split ( split , divvy , splitPlaces , oneOf )

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] , 
 x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]  
   
eliminateMultiply :: String -> String
eliminateMultiply str = until ( null . findIndices (== '*' )) step str
   where
    step :: String -> String
    step aString = if null $ findIndices (== '*') aString then aString else
     firstPart ++ show theProduct ++ secondPart
      where
	 pos :: Int
	 pos = head $ findIndices (== '*') aString
	 firstOperand :: String
	 firstOperand = reverse $ takeWhile isDigit $ reverse $ take pos aString
	 secondOperand :: String
	 secondOperand = takeWhile isDigit $ drop ( pos + 1 ) aString
	 theProduct :: Int
	 theProduct = (read firstOperand :: Int) * ( read secondOperand :: Int)
         firstPart :: String
	 firstPart = take ( pos - length firstOperand ) aString
	 secondPart :: String 
	 secondPart = drop ( pos + 1 + length secondOperand ) aString

createSeparationPoints :: String -> [[Int]]
createSeparationPoints str = 
   let l = length str
       numbers = concat $ map (\i -> take ( div l i ) $ repeat i ) [1..l - 1]
       allCombis = concat $ map (\i -> combinations i numbers ) [1..l]
       selected = filter ( (l ==) . sum ) $ S.toList $ S.fromList allCombis    
       allReversed = map reverse selected
   in S.toList $ S.fromList ( selected ++ allReversed )    

separateString :: [Int] -> String -> [String]
separateString  list str = splitPlaces list str

findOperatorCombinations :: Int -> [String]
findOperatorCombinations splitNumber = 
   let allLetters = foldl1 ( ++ ) $ map (\c -> take splitNumber $ repeat c) "+-*"
       allCombis =  combinations splitNumber allLetters 
       allReversed = map reverse allCombis 
   in S.toList $ S.fromList ( allCombis ++ allReversed )    

insertOperators :: [String] -> String -> String
insertOperators stringlist operators = 
   let zipped = zip stringlist operators
   in (foldl1 ( ++ ) $ map (\p -> fst p ++ [snd p] ) zipped) ++ last stringlist
   
combineWithOperators :: [String] -> [String]
combineWithOperators stringlist = 
   let opCombis = findOperatorCombinations ( length stringlist - 1 )
   in map (\str -> insertOperators stringlist str ) opCombis

findAllStringCombinations :: String -> [String]
findAllStringCombinations str =
   let sepPoints = createSeparationPoints str
       separatedStrings = map (\subli -> separateString subli str ) sepPoints
   in concat $ map combineWithOperators separatedStrings    

newEvaluate :: String -> String
newEvaluate str = head $ until ( (== 1 ) . length ) step $ split ( oneOf "+-" ) $ 
 eliminateMultiply str 
   where
     step :: [String] -> [String]
     step aList = [if aList !! 1 == "+" then show (firstnum + secondnum ) else show (firstnum - 
      secondnum )] ++ drop 3 aList
        where
	  firstnum = read $ aList !! 0
	  secondnum = read $ aList !! 2

main :: IO ( )
main = do
   putStrLn "Enter a string consisting of digits only!"
   numberline <- getLine
   putStrLn "Enter a target string!"
   target <- getLine
   if numberline == target then print [numberline ++ "+0" , numberline ++ "-0"] else 
    print $ filter ( (== target) . newEvaluate ) $ findAllStringCombinations numberline
