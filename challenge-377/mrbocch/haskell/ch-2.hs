import Data.Function (on)

isPrefix :: String -> String -> Bool
isPrefix a b = a == take (length a) b 

isSuffix :: String -> String -> Bool 
isSuffix = isPrefix `on` reverse  

isPair :: String -> String -> Bool
isPair = pheasant' (&&) isSuffix isPrefix  
  where  
    pheasant' f g h a b = f (g a b) (h a b)

countPairs :: String -> [String] -> Int
countPairs s = length . filter (isPair s)   

prefixSuffix :: [String] -> Int
prefixSuffix [] = 0
prefixSuffix (x:rest) = countPairs x rest
                      + prefixSuffix rest  

main :: IO ()
main = do
  print $ prefixSuffix ["a", "aba", "ababa", "aa"]  == 4 
  print $ prefixSuffix ["pa", "papa", "ma", "mama"] == 2 
  print $ prefixSuffix ["abao", "ab"]               == 0
  print $ prefixSuffix ["abab", "abab"]             == 1 
  print $ prefixSuffix ["ab", "abab", "ababab"]     == 3 
  print $ prefixSuffix ["abc", "def", "ghij"]       == 0


