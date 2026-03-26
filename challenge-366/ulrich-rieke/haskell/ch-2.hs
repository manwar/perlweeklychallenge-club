module Challenge366_2
   where
import Data.Char( isDigit , digitToInt )
import Data.List.Split( splitOn ) 

hourPart :: String -> Int
hourPart str 
   |str == "??" = 24
   |c == '?' && isDigit d = if digitToInt d < 4 then 3 else 2
   |isDigit c && d == '?' = if digitToInt c < 2 then 10 else 4
   |otherwise             = 1
    where
     c = head str
     d = last str

minutePart :: String -> Int
minutePart str = product $ map (\p -> if fst p == '?' then snd p else 1 ) $
 zip str [6 , 10]

solution :: String -> Int
solution timeterm = 
   let [hours , minutes ] = splitOn ":" timeterm
   in hourPart hours * ( minutePart minutes )

main :: IO ( ) 
main = do
   print $ solution "?2:34"
   print $ solution "?4:?0"
   print $ solution "??:??"
   print $ solution "?3:45"
   print $ solution "2?:15"
