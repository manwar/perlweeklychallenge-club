module Challenge273_2
   where
import Data.List ( findIndex ) 
import Data.Maybe ( fromJust ) 

condition :: String -> Bool
condition str = elem 'b' str && notElem 'a' ( drop ( pos + 1 ) str )
 where
  pos :: Int
  pos = fromJust $ findIndex ( == 'b' ) str

main :: IO ( )
main = do
   putStrLn "Enter a word!" 
   word <- getLine
   print $ condition word
