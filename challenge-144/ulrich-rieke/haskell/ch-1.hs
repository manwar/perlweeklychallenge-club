module Challenge144
  where
import Data.List ( subsequences , sort )

solution :: [Int]
solution = sort $ filter ( <= 100 ) ((map ( ^ 2 ) primes) ++ theList)
  where
      theList :: [Int]
      theList = map product $ filter( (== 2) . length )
      $ subsequences primes
      primes :: [Int]
      primes = filter isPrime [2 .. 100]

divisors :: Int -> [Int]
divisors n = filter (\i -> mod n i == 0 ) [1 .. n]

isPrime :: Int -> Bool
isPrime n = divisors n == [1 , n]
