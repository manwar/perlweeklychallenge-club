module Challenge242
   where
import qualified Data.Set as S

solution :: [Int] -> [Int] -> ([Int] , [Int] )   
solution firstNums secondNums = ( S.toList firstDiffSet , 
 S.toList secondDiffSet )
 where
  firstDiffSet = (S.fromList firstNums) S.\\ ( S.fromList secondNums ) 
  secondDiffSet = (S.fromList secondNums ) S.\\ (S.fromList firstNums )

main :: IO ( )
main = do
   putStrLn "Enter some integers, separated by blanks!" 
   firstNums <- getLine
   putStrLn "Enter some more integers, separated by blanks!"
   secondNums <- getLine 
   let firstNumbers = map read $ words firstNums
       secondNumbers = map read $ words secondNums
       thePair = solution firstNumbers secondNumbers
   print thePair    
