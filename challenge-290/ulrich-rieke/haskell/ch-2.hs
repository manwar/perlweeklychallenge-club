module Challenge290_2
   where
import Data.Char ( isDigit , digitToInt , isSpace ) 
import Data.List ( tail ) 

digitSum :: Int -> Int
digitSum = sum . map digitToInt . show  

findSums :: String -> Int
findSums term = sum $ map myFunction $ zip [1,2..] (filter isDigit term )
 where
  myFunction :: (Int , Char ) -> Int
  myFunction ( i , c ) 
   |even i = digitToInt c
   |otherwise = if mySum < 10 then mySum else digitSum mySum 
    where
     mySum = 2 * ( digitToInt c ) 

luhnCheck :: String -> Bool 
luhnCheck numberterm =
   let condensed = filter ( not . isSpace ) numberterm
       reversed = reverse condensed
       payload = digitToInt $ head reversed 
       totalsum = findSums $ tail reversed
  in mod (totalsum + payload) 10 == 0      
  
main :: IO ( )
main = do
   putStrLn "Enter a string consisting of numbers only!" 
   number <- getLine
   print $ luhnCheck number 
