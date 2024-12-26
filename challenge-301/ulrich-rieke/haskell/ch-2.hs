module Challenge301_2
   where
import Data.Bits 
import qualified Data.Set as S

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] , 
 x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]  

hamming_distance :: Int -> Int -> Int 
hamming_distance first second =
   let orred = first .|. second
       anded = first .&. second
   in popCount orred - popCount anded

solution :: [Int] -> Int
solution list = 
   let allCombis = S.toList $ S.fromList $ combinations 2 list
   in sum $ map (\subli -> hamming_distance ( head subli ) ( last subli ) ) 
    allCombis

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by whitespace!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
