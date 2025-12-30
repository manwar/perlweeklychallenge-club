module Challenge354
   where
import Data.List ( sort )
import Data.List.Split ( divvy )

solution :: [Int] -> [[Int]]
solution list =
   let neighbours = divvy 2 1 $ sort list
       mindiff = minimum $ map(\p -> last p - head p) neighbours
   in filter (\subli -> last subli - head subli == mindiff ) neighbours

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
