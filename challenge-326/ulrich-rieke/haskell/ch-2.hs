module Challenge326_2
   where
import Data.List.Split (chunksOf )

solution :: [Int] -> [Int]
solution list = foldl1 ( ++ ) $ map (\subli -> replicate ( head subli )
 ( last subli ) ) $ chunksOf 2 list

main :: IO ( ) 
main = do
   putStrLn "Enter an even amount of positive integers separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
