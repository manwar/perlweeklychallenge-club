module Ch2 where

import Data.Char (isDigit)

alphanumericStringValue :: [String] -> Int
alphanumericStringValue xs =
  maximum $ map (\x -> if all isDigit x then read x :: Int else length x) xs
    
main :: IO ()
main = do
  print $ alphanumericStringValue ["perl","2","000","python","r4ku"]
  print $ alphanumericStringValue ["001","1","000","0001"]

