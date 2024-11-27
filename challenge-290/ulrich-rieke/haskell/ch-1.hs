module Challenge290
   where
import Data.List ((!!))

makePairs :: [Int] ->[(Int , Int)]
makePairs list = [(list !! i , list !! j) | i <- [0..l - 2] , j <- [i + 1 ..
 l - 1]]
  where
   l = length list

solution :: [Int] -> Bool
solution list = any (\p -> fst p == (2 * ( snd p )) ) $ makePairs list

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!" 
   numberline <- getLine 
   print $ solution $ map read $ words numberline

