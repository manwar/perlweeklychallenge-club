import Data.Function

convertPalindrome :: String -> String
convertPalindrome s = reverse outer ++ take lengthSubPalidrome s ++ outer
  where
    lengthSubPalidrome :: Int 
    lengthSubPalidrome =
      [1 .. length s]
        & map (flip take s)
        & filter isPalidrome
        & map length
        & maximum

    outer :: String 
    outer = drop lengthSubPalidrome s

    isPalidrome :: Eq a => [a] -> Bool 
    isPalidrome xs = xs == reverse xs

main :: IO()
main = do
  print $ convertPalindrome "pinnipeds"  == "sdepinnipeds"
  print $ convertPalindrome "abcd"       == "dcbabcd"
  print $ convertPalindrome "bananas"    == "sananabananas"
  print $ convertPalindrome "dissident"  == "tnedissident"
  print $ convertPalindrome "cailliachs" == "shcailliachs"
