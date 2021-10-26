module Challenge135_2
  where
import Data.Char
import Data.List ( (!!) )

firstCondition :: String -> Bool
firstCondition s = length s == 7

secondCondition :: String -> Bool
secondCondition s = not $ any (\c -> elem c "AEIOU" ) s

thirdCondition :: String -> Bool
thirdCondition str = (intToDigit ( mod (10 - ( mod theSum 10)) 10 )) == last str
where
  weights :: [Int]
  weights = [1, 3 , 1 , 7 , 3 , 9 , 1]
  convert :: Char -> Int
  convert letter = if isUpper letter then ord letter - 55 else digitToInt letter
  theSum :: Int
  theSum =  sum $ map (\p -> (convert $ fst p) * ( snd p )) $ take 6 $ zip str
  weights

solution :: String -> Int
solution sedol = if firstCondition converted && secondCondition converted &&
thirdCondition converted then 1 else 0
where
  converted :: String
  converted = map toUpper sedol
