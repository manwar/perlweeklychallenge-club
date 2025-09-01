module Challenge337
   where
import Data.List ( (!!) )

numberOfElements :: [Int] -> Int -> Int
numberOfElements list comparison = 
   let selected = length $ filter ( <= comparison ) list
   in if selected > 0 then selected - 1 else 0 

solution :: [Int] -> [Int]
solution list = map (\i -> numberOfElements list ( list !! i ) ) [0..length list - 1]

main :: IO ( )
main = do
   putStrLn "Enter a list of integers separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
