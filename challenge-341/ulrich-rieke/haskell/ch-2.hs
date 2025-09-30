module Challenge341_2
   where
import Data.List ( findIndex ) 
import Data.Maybe ( fromJust ) 

solution :: [String] -> String
solution input = (reverse $ take ( pos + 1 ) first) ++ drop ( pos + 1 ) first 
 where
  first :: String
  first = head input
  letter :: Char
  letter = head $ last input
  pos :: Int
  pos = fromJust $ findIndex ( == letter ) first 

main :: IO ( ) 
main = do 
   putStrLn "Enter a string and a letter from that string!"
   inputLine <- getLine
   print $ solution $ words inputLine
