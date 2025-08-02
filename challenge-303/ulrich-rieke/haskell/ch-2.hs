module Challenge303_2
   where
import Data.List ( permutations )

splitOff :: [Int] -> [[Int]]
splitOff [] = [[]]
splitOff (x:xs) = [ x : firstPart] ++ (splitOff $ drop
 ( length firstPart ) xs)   
  where
   firstPart = takeWhile (\n -> abs( x - n ) == 1 ) xs

findSum :: [[Int]] -> Int
findSum sublists = sum $ map head $ filter ( not . null ) sublists

findSublists :: [Int] -> [[[Int]]]
findSublists list =
   let permus = permutations list
   in map splitOff permus

solution :: [[[Int]]] -> Int
solution allSublists = maximum $ map findSum allSublists

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by whitespace!"
   numberline <- getLine
   let sublists = findSublists $ map read $ words numberline
   print $ solution sublists
