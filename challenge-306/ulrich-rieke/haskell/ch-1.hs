module Challenge306
   where
import Data.List.Split( divvy ) 

findSubarraySum :: [Int] -> Int -> Int
findSubarraySum list subarraylen = if (subarraylen == 1 || subarraylen == length
 list) then sum list else sum $ map sum $ divvy subarraylen 1 list

solution :: [Int] -> Int
solution list = sum $ map (\i -> findSubarraySum list i) $ filter odd [1..
 length list]

main :: IO ( )
main = do
   putStrLn "Enter some positive integers separated by whitespace!" 
   numberline <- getLine
   print $ solution $ map read $ words numberline
