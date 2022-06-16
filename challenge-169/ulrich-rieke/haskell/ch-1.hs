module Challenge169
  where

divisors :: Int -> [Int]
divisors n = [d | d <- [2 .. n] , mod n d == 0 ]

primeDecompose :: Int -> [Int]
primeDecompose n = snd $ until ( (== 1) . fst ) step (n , [] )
where
  step :: ( Int , [Int] ) -> ( Int , [Int] )
  step ( d , list ) = ( div d h , list ++ [h] )
  where
    h = head $ divisors d

isBrilliant :: Int -> Bool
isBrilliant n = (( length primeFactors  ) == 2) && (l1 == l2 )
where
  primeFactors :: [Int]
  primeFactors = primeDecompose n
  l1 :: Int
  l1 = length $ show $ head primeFactors
  l2 :: Int
  l2 = length $ show $ last primeFactors

solution :: [Int]
solution = take 20 $ filter isBrilliant [2 , 3 ..]
