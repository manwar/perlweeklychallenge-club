import Data.Char
import Data.Function

decodeString :: String -> String
decodeString "" = ""

decodeString xs@(c:cs)
  | isLetter c    = c : decodeString cs
  | isNumber c    = decodeString (concat $ replicate num inner) ++ decodeString rest
  | otherwise = undefined 
  where
    n :: String 
    n = takeWhile isNumber xs

    num :: Int 
    num = read n 
    inner :: String
    inner = dropWhile isNumber xs
          & drop 1
          & flip takeGroup 1 

    rest :: String
    rest = drop (length inner + length n + 2) xs 

    takeGroup :: String -> Int -> String
    takeGroup "" lvl
      | lvl == 1  = ""
      | otherwise = undefined 

    takeGroup (c:cs) lvl 
      | c == ']' && lvl == 1 = ""
      | c == '['             = c : takeGroup cs (lvl+1)
      | c == ']'             = c : takeGroup cs (lvl-1)
      | otherwise            = c : takeGroup cs lvl 

main :: IO ()
main = do
  print $ decodeString "2[3[a]]"      == "aaaaaa"
  print $ decodeString "10[a]"        == "aaaaaaaaaa"
  print $ decodeString "a2[b]c3[d]e"  == "abbcddde"
  print $ decodeString "2[a2[b]c]"    == "abbcabbc"
  print $ decodeString "1[a]2[b3[c]]" == "abcccbccc"
  print $ decodeString "a1[b3[c]z]"   == "abcccz"


