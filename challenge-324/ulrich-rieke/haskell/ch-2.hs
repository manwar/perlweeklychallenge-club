module Challenge324_2
   where
import qualified Data.Set as S
import Data.Bits ( xor ) 

solution :: [Int] -> Int
solution = sum . map op . filter ( not . null ) . map S.toList . S.toList
 . S.powerSet . S.fromList
    where
     op :: [Int] -> Int
     op list = if length list == 1 then head list else foldl1 xor list

main :: IO ( ) 
main = do 
   putStrLn "Enter some integers separated by blanks!" 
   numberline <- getLine
   print $ solution $ map read $ words numberline 
