module Challenge303
   where
import Data.List ( sort , permutations )
import qualified Data.Set as S

--we know the lists to have 3 numbers only   
toNumber :: [Int] -> Int
toNumber list = sum $ zipWith ( * ) [100 , 10 , 1] list

solution :: [Int] -> [Int]
solution list =
   let permus = permutations list
       three_digits = if length list == 3 then permus else map ( take 3 ) permus
       selected = filter ( (/= 0 ) . head ) three_digits
       numbers = map toNumber selected
   in sort $ S.toList $ S.fromList $ filter even numbers    

main :: IO ( ) 
main = do
   putStrLn "Enter at least 3 one-digit positive integers separated by whitespace!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
