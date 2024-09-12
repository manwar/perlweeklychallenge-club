module Challenge286_2
   where
import Data.List.Split ( chunksOf ) ;

solution :: [Int] -> Int
solution list = head $ until ( (== 1 ) . length ) step list
 where
  step :: [Int] -> [Int]
  step someList = map (\p -> if (fst p ) then min ( head $ snd p ) ( last $ snd
   p ) else max ( head $ snd p ) ( last $ snd p ) ) $  zip ( cycle [True ,
    False] ) (chunksOf 2 someList)

main :: IO ( )
main = do
   putStrLn "Enter 2 ^ n integers where n is a positive integer!" 
   numberstrings <- getLine
   print $ solution $ map read $ words numberstrings
