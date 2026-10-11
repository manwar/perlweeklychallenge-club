module Challenge394_2
   where
import Data.List ( sortOn )
import qualified Data.Set as S

vowels :: [Char]
vowels = "aeiou"

isAlternating :: String -> Bool
isAlternating str = if elem ( head str ) vowels then all (\p -> if even $ fst p then
 elem ( snd p ) vowels else notElem ( snd p ) vowels ) pairs else all (\p -> if 
  even $ fst p then notElem ( snd p ) vowels else elem ( snd p ) vowels ) pairs
   where
      pairs :: [(Int , Char)]
      pairs = zip [0 , 1 ..] str

allSubstrings :: String -> [String]
allSubstrings str =
   let l = length str
   in [take i $ drop j str | i <- [1..l] , j <- [0..l] , i + j <=  l]

solution :: [String] -> [String]
solution strings = 
   let allCommon = foldl1 S.intersection $ map ( S.fromList . allSubstrings ) strings
       selected = if S.null allCommon then [] else filter isAlternating $ S.toList 
        allCommon
       sorted = if null selected then [] else sortOn length selected
   in if null sorted then [] else filter (\s -> length s == ( length $ last sorted ))
    sorted

main :: IO ( )
main = do
   putStrLn "Enter some strings with English alphabetic characters only!"
   line <- getLine
   print $ solution $ words line
