module Challenge234
   where
import qualified Data.Set as S
import Data.List ( intercalate ) 

count :: Eq a => a -> [a] -> Int
count w [] = 0 ;
count w (x:xs) = if w == x then 1 + count w xs else count w xs

findUniqueLetters :: [String] -> [Char]
findUniqueLetters list = S.toList $ foldl1 S.intersection (map S.fromList
 list )     

findLetterFrequencies :: [String] -> [(Char , Int)]
findLetterFrequencies strings = map (\(l, subli) -> (l , minimum subli)) $ 
 map (\l -> (l , map (\w -> count l w )  strings )) uniqueLetters	 
 where
  uniqueLetters = findUniqueLetters strings

solution :: [(Char , Int)] -> [Char]
solution slist = foldl1 ( ++ )
 $ map (\p -> replicate ( snd p ) (fst p )) slist

forOutput :: [Char] -> String
forOutput letters = "(" ++ (intercalate ", " $ map wrap letters) ++ ")"
 where
  wrap c = [c]

main :: IO ( )
main = do
   putStrLn "Please enter some words , separated by spaces!" 
   strings <- getLine
   let frequencies = findLetterFrequencies $ words strings
   print ( forOutput $ solution frequencies )
