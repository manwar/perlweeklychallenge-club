module Challenge107
  where
import Data.Char ( intToDigit , digitToInt )
import Data.List ( ( !! ) )

theDigits ::[Char]
theDigits = map intToDigit [0..9]

isSelfDescriptive :: String -> Bool
isSelfDescriptive number = (all firstCondition number) && ( all secondCondition $
zip [0 .. length number - 1 ] number )
  where
  firstCondition :: Char -> Bool
  firstCondition c = elem c theDigits
  secondCondition :: (Int, Char) -> Bool
  secondCondition ( i , c ) = count (intToDigit i ) number == digitToInt ( number !! i )

count :: Ord a => a -> [a] -> Int
count d [] = 0 ;
count d (x:xs)
  |d == x = 1 + count d xs
  |otherwise = count d xs

isValidNumber :: String -> Int -> Bool
isValidNumber n base = (all (\i -> i < base ) $ map digitToInt n ) && ( length n
== base )

findValidNumbers :: Int -> [String]
findValidNumbers base = filter (\i -> isValidNumber i base) numberlist
where
  start :: Int
  start = read ( "1" ++ (take ( base - 1 ) $ repeat '0' ))
  end :: Int
  end = read ( map intToDigit $ take base  $ repeat (base - 1) )
  numberlist :: [String]
  numberlist = map show [start .. end]

solution :: [Int] -> [String]
solution bases = filter isSelfDescriptive $ concat $ map(\b -> findValidNumbers b) bases
