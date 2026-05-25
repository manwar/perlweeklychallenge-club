module Challenge375_2
   where
import Data.List.Split ( divvy )
import Data.Char ( digitToInt ) 

solution :: String -> String -> Int
solution numberstring kvalue 
   |l == k = 1
   |l < k = 0
   |otherwise = if k > 1 then length $ filter ( (== 0) . mod number ) $
    map read $ divvy k (k - 1 ) numberstring else length $ filter ( (== 0 )      . mod number ) $ map digitToInt numberstring
     where
      l :: Int
      l = length numberstring
      k :: Int
      k = read kvalue
      number :: Int
      number = read numberstring

main :: IO ( ) 
main = do
   putStrLn "Enter a number string!"
   numberstring <- getLine
   putStrLn "Enter a k value!"
   kvalue <- getLine
   print $ solution numberstring kvalue
