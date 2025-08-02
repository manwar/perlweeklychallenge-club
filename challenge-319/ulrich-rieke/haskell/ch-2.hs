module Challenge319_2
   where
import qualified Data.Set as S

solution :: [Int] -> [Int] -> Int
solution firstList secondList = 
   let
      firstset = S.fromList firstList
      secondset = S.fromList secondList
      common = S.intersection firstset secondset
   in if S.null common then -1 else minimum $ S.toList common

main :: IO ( ) 
main = do
   putStrLn "Enter some integers separated by blanks!"
   firstLine <- getLine
   putStrLn "Enter some more integers separated by blanks!" 
   secondLine <- getLine
   print $ solution ( map read $ words firstLine ) ( map read $ words 
    secondLine )	 
