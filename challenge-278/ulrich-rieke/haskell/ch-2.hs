module Challenge278_2
 where
import Data.List ( sort , findIndex )
import Data.Maybe ( fromJust )   

solution :: String -> Char -> String
solution haystack needle = if notElem needle haystack then haystack else ( sort 
 $ take ( pos + 1 ) haystack ) ++ drop ( pos + 1 ) haystack 
 where
  pos = fromJust $ findIndex ( == needle ) haystack

main :: IO ( )
main = do
   putStrLn "Enter a word and a character, separated by blanks!"
   myLine <- getLine
   let [haystack , needle] = words myLine
   print $ solution haystack ( head needle )
