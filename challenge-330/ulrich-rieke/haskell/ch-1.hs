module Challenge330
   where
import Data.List.Split ( divvy )
import Data.Char ( isLetter , isDigit ) 
import Data.List ( findIndex ) 

removePair :: String -> Int -> String
removePair str at = take at str ++ drop ( at + 2 ) str

condition :: String -> Bool
condition str = (isLetter $ head str) && ( isDigit $ last str )

solution :: String -> String
solution str = until (\s -> not $ any condition $ divvy 2 1 s) step str
   where
      step :: String -> String
      step someString = case findIndex condition $ divvy 2 1 someString of
	 Just pos -> removePair someString pos
	 Nothing  -> someString

main :: IO ( )
main = do
   putStrLn "Enter a word with lowercase English letters and digits only!"
   word <- getLine
   print $ solution word
