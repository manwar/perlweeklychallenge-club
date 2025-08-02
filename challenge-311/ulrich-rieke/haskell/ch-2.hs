module Challenge311_2
   where
import Data.List.Split ( chunksOf ) 
import Data.Char ( digitToInt )
import Control.Monad.State.Lazy

digitSum :: String -> Int
digitSum = sum . map digitToInt

toSumString :: [String] -> String
toSumString = foldl1 ( ++ ) . map ( show . digitSum )
   
findString :: Int -> State String String
findString chopsize = do
   startstring <- get
   let chopped = chunksOf chopsize startstring
       sumstring = toSumString chopped
   if length sumstring <= chopsize then do pure sumstring
   else do
      put sumstring
      findString chopsize


solution :: String -> String -> String
solution numberstring chopsize = evalState ( findString ( read chopsize ) ) 
 numberstring   

main :: IO ( )
main = do 
   putStrLn "Enter a string consisting of digits only!"
   numberstring <- getLine
   putStrLn "Enter a number less than the length of the string!"
   number <- getLine
   print $ solution numberstring number
