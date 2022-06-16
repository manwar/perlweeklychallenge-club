module Challenge169_2
  where
import Data.List ( group )

divisors :: Int -> [Int]
divisors n = [d | d <- [2 .. n] , mod n d == 0 ]

primeDecompose :: Int -> [Int]
primeDecompose n = snd $ until ( (== 1) . fst ) step (n , [] )
where
  step :: ( Int , [Int] ) -> ( Int , [Int] )
  step ( d , list ) = ( div d h , list ++ [h] )
  where
    h = head $ divisors d

isAchilles :: Int -> Bool
isAchilles n = myCondition  && ( (foldl1 gcd theLengths ) == 1 )
where
  theLengths :: [Int]
  theLengths = map length $ group $ primeDecompose n
  myCondition :: Bool
  myCondition = if null theLengths then False else (minimum theLengths) >= 2

solution :: [Int]
solution = take 20 $ filter isAchilles [2 , 3 ..]
