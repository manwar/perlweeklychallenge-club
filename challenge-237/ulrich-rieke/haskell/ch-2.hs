module Challenge237_2
   where
import Data.List ( permutations )

solution :: [Int] -> Int
solution list = maximum greaterNums
 where
  permus :: [[Int]]
  permus = permutations list
  listPairs :: [[(Int , Int)]]
  listPairs = map (\perm -> zip perm list) permus
  greaterNums :: [Int]
  greaterNums = map (\p ->  length $ filter(\pa -> fst pa > snd pa ) p )
   listPairs

main :: IO ( )
main = do
   putStrLn "Please enter some integers, separated by blanks!"
   numberstrings <- getLine
   let numbers = map read $ words numberstrings
   print $ solution numbers
