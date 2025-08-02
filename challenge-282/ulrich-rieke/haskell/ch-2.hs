module Challenge282_2
   where
import Data.List.Split ( divvy ) 
import Data.Char ( toLower ) 

solution :: String -> Int
solution s = length $ filter (\w -> head w /= last w ) $ map ( map toLower)
  $ divvy 2 1 s
