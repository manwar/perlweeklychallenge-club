module Challenge297
   where
import Data.List ( sortOn ) 

count :: Eq a => a -> [a] -> Int
count _ [] = 0 
count el (x:xs)
   |el == x = 1 + count el xs
   |otherwise = count el xs
   
solution :: [Int] -> Int
solution binaries
   |all (\i -> i == head binaries) binaries = 0
   |otherwise =
      let starts = [0..length binaries - 2]
	  sublists = [take n $ drop s binaries| s <- starts , n <- [2..length 
	   binaries - s]]
	  pairs = map (\subl -> ( count 0 subl , count 1 subl ) ) sublists
	  relevantPairs = filter (\p -> fst p == snd p ) pairs
	  sorted = sortOn fst relevantPairs
      in (fst $ last sorted ) + ( snd $ last sorted )

main :: IO ( )
main = do
   putStrLn "Enter some 0 and 1 separated by whitespace!" 
   numberline <- getLine
   print $ solution $ map read $ words numberline

