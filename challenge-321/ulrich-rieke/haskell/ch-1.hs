module Challenge321
   where
import qualified Data.Set as S
import Data.List( sort )
--the basic idea is : we sort the list and then pair the smallest with the
--largest element, the second smallest with the second largest and so on
--by zipping the first half of the sorted element with the reversed second half

solution :: [Double] -> Int
solution list =
   let
      sorted = sort list
      half   = div (length sorted) 2 
      zipped = zip ( take half sorted ) ( reverse $ drop half sorted )
      averages = S.fromList $ map (\p -> ( fst p + snd p ) / 2.0 ) zipped
   in S.size averages

main :: IO ( )
main = do
   putStrLn "Enter an even number of numbers separated by whitespace!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
