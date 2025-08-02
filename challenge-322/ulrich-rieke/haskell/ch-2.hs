module Challenge322_2
   where
import qualified Data.Set as S
import Data.List ( sort )
import Data.Maybe ( fromJust ) 

solution :: [Int] -> [Int]
solution list =
   let uniques = S.toList $ S.fromList $ sort list
       zipped = zip uniques [1, 2 ..]
   in map (\n -> fromJust $ lookup n zipped ) list

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
