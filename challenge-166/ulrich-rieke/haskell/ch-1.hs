module Challenge166
  where
import Data.Maybe ( fromJust )
import Data.List ( findIndex , (!!) )
import Data.Char ( isLetter , isDigit )

myCondition :: String -> Bool
myCondition str = len > 1 && len < 9 && all (\l -> elem l allowed ) str
where
  len :: Int
  len = length str
  allowed :: [Char]
  allowed = ['0'..'9'] ++ ['a' .. 'e']

transpose :: String -> String
transpose str = map (\c -> if c `elem` from then shift c else c ) str
where
  from :: [Char]
  from = ['o', 'l' , 'i' , 's' , 't']
  to  :: [Char]
  to  = ['0' , '1' , '1' , '5' , '7']
  shift :: Char -> Char
  shift letter = to !! ( fromJust $ findIndex (== letter) from )

pickWord :: String -> String
pickWord str
  |myCondition str = str
  |myCondition $ transpose str = transpose str
  |not $ myCondition str && (not $ myCondition $ transpose str )  = ""

main :: IO ( )
main = do
  allWords <- readFile "myDictionary.txt"
  let singleWords = lines allWords
      sanitized = map (\str -> takeWhile (\c -> isDigit c || isLetter c ) str )
        singleWords--an unusual \r appears in the original file which has to be removed
      selected = map pickWord sanitized
  mapM_ (\w -> putStrLn ( "0#" ++ w)) $ filter ( not . null ) selected
