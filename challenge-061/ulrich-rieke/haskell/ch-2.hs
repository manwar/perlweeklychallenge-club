module Challenge061_2
  where
import Data.List.Split ( splitPlaces )
import Data.List ( intercalate )

isValidOctet :: String -> Bool
isValidOctet s = number >= 0 && number <= 255
  where
      number = read s

findCombinations :: Int -> [[Int]]
findCombinations len = [[a, b , c , d] | a <- [1..3] , b <- [1..3] ,
c <- [1..3] , d <- [1..3] , a + b + c + d == len]

possibleIPs :: String -> [String]
possibleIPs input =
      let len = length input
      inputsplits = map (\li -> splitPlaces li input ) $ findCombinations len
      iplists = filter (\spl -> all(\letters -> isValidOctet letters) spl )
      inputsplits
      in map (\st -> intercalate "." st ) iplists

validIPs :: String -> [String]
validIPs ip
  |len < 4 || len > 12 = []
  |otherwise = possibleIPs ip
    where
      len = length ip
