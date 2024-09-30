module Challenge289
   where
import qualified Data.Set as S
import Data.List ((!!) , sort ) 

solution :: [Int] -> Int
solution list
   |length list < 3 = maximum list
   |otherwise = if length uniques < 3 then maximum uniques else sorted !! ( length sorted - 3 )
    where
     uniques :: [Int]
     uniques = S.toList $ S.fromList list
     sorted :: [Int]
     sorted = sort uniques

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
