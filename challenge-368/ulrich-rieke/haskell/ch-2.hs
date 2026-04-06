module Challenge368_2
   where
import qualified Data.Set as S

divisors :: Int -> [Int]
divisors n = [d | d <- [2..n] , mod n d == 0]

findFactors :: Int -> [Int]
findFactors n = snd $ until ( (== 1 ) . fst ) step ( n , [] ) 
   where
      step :: ( Int , [Int] ) -> ( Int , [Int] )
      step ( aNumber , aList ) = ( div aNumber smallest , aList ++ [smallest] )
       where
         smallest :: Int
         smallest = head $ divisors aNumber

solution :: Int -> Int -> Int
solution number mode = if mode == 0 then length $ S.toList $ S.fromList factors
 else length factors  
   where
      factors = findFactors number

main :: IO ( )
main = do
   putStrLn "Enter a positive number!" 
   numberline <- getLine
   putStrLn "Enter a mode ( 0 or 1 )!"
   modeline <- getLine
   print $ solution ( read numberline ) ( read modeline )
