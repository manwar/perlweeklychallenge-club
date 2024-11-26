module Challenge297_2
   where
import Data.List ( findIndex )
import Data.Maybe ( fromJust )

solution :: [Int] -> Int
solution list =
   let maxi = maximum list
       mini = minimum list
       minpos = fromJust $ findIndex ( == mini ) list
       maxpos = fromJust $ findIndex ( == maxi ) list
       len = length list
   in if minpos < maxpos then minpos + len - 1 - maxpos else minpos + len - 1 - maxpos
    - 1 

main :: IO ( )
main = do
   putStrLn "Enter some unique integers separated by whitespace!" 
   numberline <- getLine
   print $ solution $ map read $ words numberline
