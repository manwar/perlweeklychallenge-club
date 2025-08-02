module Challenge329_2
   where
import Data.Char 
import Data.List ( sortOn ) 

condition :: String -> Bool
condition str = all (\letter -> any(\l -> abs ( ord l - ord letter ) == 32 ) str ) str

substr :: String -> Int -> Int -> String
substr str from to = take ( to - from + 1 ) $ drop from str

findSubstrings :: String -> [String]
findSubstrings str = [substr str from to | from <- [0..l - 2] , to <- [from + 1 ..
 l - 1]] 
   where
      l :: Int
      l = length str

solution :: String -> String
solution str = if null sorted then "" else last sorted
   where
    substrings :: [String]
    substrings = findSubstrings str
    selected   :: [String]
    selected   = filter condition substrings
    sorted     :: [String]
    sorted = if null selected then [] else sortOn length selected

main :: IO ( )
main = do
   putStrLn "Enter a word with uppercase and lowercase English letters!"
   word <- getLine
   print $ solution word
