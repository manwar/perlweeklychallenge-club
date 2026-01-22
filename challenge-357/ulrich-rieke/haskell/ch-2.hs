module Challenge357_2
   where
import Data.Ratio
import qualified Data.Set as S
import Data.List( sortBy ) 

solution :: Int -> [String]
solution number =
   let fractions = [num % denom | num <- [1..number] , denom <- [1..number]]
       uniques = S.toList $ S.fromList fractions
   in map toString $ sortBy mySorter uniques    
   
mySorter :: Ratio Int -> Ratio Int -> Ordering
mySorter firstRat secondRat = compare ( (fromIntegral ( numerator firstRat)) /
 (fromIntegral ( denominator firstRat ) )) ( (fromIntegral ( numerator 
  secondRat )) / ( fromIntegral( denominator secondRat ) ) )        

toString :: Ratio Int -> String 
toString rat = show ( numerator rat ) ++ "/" ++ show ( denominator rat )

main :: IO ( )
main = do
   putStrLn "Enter a positive integer!"
   numberline <- getLine
   print $ solution $ read numberline
