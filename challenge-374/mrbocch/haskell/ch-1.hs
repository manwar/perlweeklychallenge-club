import qualified Data.Set as Set

countVowel :: String -> [String]
countVowel = filter allVowels
           . filter (all isVowel)
           . filter ((>= 5) . length)
           . sublists

-- assuming only lower case chars
isVowel :: Char -> Bool
isVowel c = (c == 'a') || (c == 'e') || (c == 'i') || (c == 'o') || (c == 'u')

allVowels :: String -> Bool
allVowels = allVowels' (0,0,0,0,0)
  where
    allVowels' :: (Int, Int, Int, Int, Int) -> String -> Bool
    allVowels' (a,e,i,o,u) "" = a >= 1 && e >= 1 && i >= 1 && o >= 1 && u >= 1
    allVowels' (a,e,i,o,u) (c:cs)
      | c == 'a' = allVowels' (a+1,e,i,o,u) cs
      | c == 'e' = allVowels' (a,e+1,i,o,u) cs
      | c == 'i' = allVowels' (a,e,i+1,o,u) cs
      | c == 'o' = allVowels' (a,e,i,o+1,u) cs
      | c == 'u' = allVowels' (a,e,i,o,u+1) cs

sublists :: [a] -> [[a]]
sublists []          = []
sublists xs@(_:rest) = map (\x -> take x xs) [1.. length xs] ++ sublists rest

main = do
  let a = Set.fromList $ countVowel "aeiou"
  let b = Set.fromList $ countVowel "aaeeeiioouu"
  let c = Set.fromList $ countVowel "aeiouuaxaeiou"
  let d = Set.fromList $ countVowel "uaeiou"
  let e = Set.fromList $ countVowel "aeioaeioa"

  let a1 = Set.fromList ["aeiou"]
  let b1 = Set.fromList ["aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu"]
  let c1 = Set.fromList ["aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua"]
  let d1 = Set.fromList ["aeiou", "uaeio", "uaeiou"]
  let e1 = Set.empty

  print $ a == a1
  print $ b == b1
  print $ c == c1
  print $ d == d1
  print $ e == e1
