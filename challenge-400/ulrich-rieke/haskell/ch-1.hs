module Challenge400
   where
import qualified Data.Set as S 
import Data.List ( (!!) )

isRepeating :: Int -> Bool
isRepeating n = and [n > 9 , (length digits) /= length ( S.toList $ S.fromList
  digits)]
   where
      digits :: [Int]
      digits = toDigits n

toDigits :: Int -> [Int]
toDigits n =  snd $ until ( (== 0 ) . fst ) step ( n , [] ) 
   where
      step :: ( Int , [Int] ) -> (Int , [Int] )
      step ( someDigit , someList ) = ( div someDigit 10 , someList ++ [
            mod someDigit 10] )

solution :: Int -> Int
solution n = maximum $ map (\i -> list !! i - ( list !! ( i - 1 ) ))
   [1..length list - 1]
    where
      list :: [Int]
      list = filter ( not . isRepeating ) [1..n]

main :: IO ( )
main = do
   putStrLn "Enter a positive integer!" 
   numberline <- getLine
   print $ solution ( read numberline :: Int )
