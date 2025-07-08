module Challenge329
   where
import Data.Char ( isLetter , isDigit )
import Data.List ( nub ) 

solution :: String -> [Int]
solution str = 
   let replaced = map (\l -> if isLetter l then ' ' else l ) str
       numberstrings = words replaced
       numbers = map read numberstrings
   in nub numbers    
   
main :: IO ( )
main = do
   putStrLn "Enter a string with lowercase English letters and digits!"
   word <- getLine
   print $ solution word
