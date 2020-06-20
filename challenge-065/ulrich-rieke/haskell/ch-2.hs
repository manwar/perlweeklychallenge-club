module Challenge065_2
  where
import Data.List ( subsequences )
import Data.List.Split ( splitPlaces )

palindromicSubstrings :: String -> [[String]]
palindromicSubstrings str =
  let positions = [1..len]
      len = length str
      lengthcombis = filter ( (len >= ) . sum ) $ subsequences positions
      allSubstrings = map (\li -> splitPlaces li str ) lengthcombis
      substringsWithPalindromes = filter (\li -> myCondition str li )
        allSubstrings
  in map (\li -> filter isPalindromic li ) substringsWithPalindromes

isStartOf :: String -> String -> Bool
isStartOf piece whole = take ( length piece ) whole == piece

isPalindromic :: String -> Bool
isPalindromic str = str == reverse str && length str > 1

myCondition :: String -> [String] -> Bool
myCondition str list
  |null list = False
  |length list == 1 = (isPalindromic $ head list) && (isStartOf ( head list )
    str )
  |otherwise = (length $ filter isPalindromic list) > 1
