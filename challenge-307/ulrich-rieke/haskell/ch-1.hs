module Challenge307
   where
import Data.List ( sort )

solution :: [Int] -> [Int]
solution list =
   let sorted = sort list
       compared = zip list sorted
       indexed = zip [0, 1 ..] compared
   in map fst $ filter (\p -> (fst $ snd p) /= (snd $ snd p)) indexed    

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by whitespace!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
