module Challenge399
   where
import Data.List ( sortOn )
import qualified Data.Set as S

count :: Eq a => a -> [a] -> Int
count _ [] = 0
count d (x:xs)
   |d == x = 1 + count d xs
   |otherwise = count d xs

findFrequencies :: String -> [(Char , Int)]
findFrequencies str = map (\c -> (c , count c str) ) $ S.toList $ 
 S.fromList str

findSubstrings :: String -> Int -> [String]
findSubstrings str k = 
   let l = length str 
   in S.toList $ S.fromList [take i $ drop j str | i <- [k..l] ,
    j <- [0..l - k] , i + j <= l] 

assessFrequencies :: [(Char , Int)] -> (Int , Int)
assessFrequencies freqs = 
   let maxi = maximum $ map snd freqs
       rest = sum $ filter ( /= maxi ) $ map snd freqs
   in ( maxi , rest )

solution :: String -> Int -> Int
solution input k = 
   let substrings = findSubstrings input k
       allFrequencies = map findFrequencies substrings
       assessed = map assessFrequencies allFrequencies
       wordFreqs = findFrequencies input
   in if all ( == head input ) input then length input else 
    if length wordFreqs == length input then k + 1 else 
     pairsum $ last $ sortOn fst $ filter ( (== k ) . snd ) assessed 

pairsum :: (Int , Int) -> Int
pairsum p = fst p + snd p

main :: IO ( )
main = do
   putStrLn "Enter a string with capital letters and an integer!"
   line <- getLine
   let elements = words line
       word = head elements
       k    = ( read $ last elements :: Int )
   print $ solution word k

