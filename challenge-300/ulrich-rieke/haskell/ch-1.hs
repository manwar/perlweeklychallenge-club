module Challenge300
   where
import Data.List ( permutations )

condition :: [Int] -> Bool
condition list = all (\p -> mod ( snd p ) ( fst p ) == 0 || mod ( fst p )
 ( snd p ) == 0 ) $ zip [1 , 2 ..] list

solution :: Int -> Int
solution number = length $ filter condition $ permutations [1..number]

main :: IO ( )
main = do
   putStrLn "Enter a positive integer!" 
   number <- getLine
   print $ solution $ read number
