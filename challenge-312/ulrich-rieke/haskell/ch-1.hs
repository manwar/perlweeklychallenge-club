module Challenge312
   where
import Data.List.Split ( divvy ) 
import Data.Maybe ( fromJust )

minDiff :: Char -> Char -> [(Char , Int)] -> Int
minDiff firstChar secondChar taggedChars =
   let
    diff1 = abs ( (fromJust $ lookup firstChar taggedChars) - 
	  (fromJust $ lookup secondChar taggedChars ) ) 
    diff2 = 26 - diff1 
   in min diff1 diff2

--does the correction if string does not start with a
findStartValue :: Char -> [(Char , Int)] -> Int   
findStartValue letter tagged = 
  let number = fromJust $ lookup letter tagged
      onedir = abs ( number - 1 ) 
      otherdir = 26 - onedir
  in min onedir otherdir

solution :: String -> Int
solution input =
   let tagged = zip ['a'..'z'] [1..26] 
       firstLetter = head input
       start = if firstLetter /= 'a' then findStartValue firstLetter tagged
        else 0
       pairs = divvy 2 1 input
       differences = map (\subli -> minDiff ( head subli ) ( last subli ) 
	tagged ) pairs
   in sum differences + start + length input 

main :: IO ( )
main = do
   putStrLn "Enter a word with smallcase English letters only!"
   word <- getLine
   print $ solution word
