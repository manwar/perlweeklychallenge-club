module Challenge133_2
  where
import Data.Char ( digitToInt )
import Control.Monad.State.Lazy
import Data.List( group )

divisors :: Int -> [Int]
divisors n = [d | d <- [2..n] , mod n d == 0]

decompose ::  State (Int , [Int]) [Int]
decompose = do
  (d , factors ) <- get
  if d == 1
      then return factors
  else do
      put ( div d ( head $ divisors d ) , factors ++ [ head $ divisors d])
      decompose

myFactors :: Int -> [Int]
myFactors n = evalState decompose ( n , [] )

isPrime :: Int -> Bool
isPrime n = myDivisors n == [1,n]
where
  myDivisors :: Int -> [Int]
  myDivisors d = [i | i <- [1 .. d] , mod d i == 0]

findDigitSum :: Int -> Int
findDigitSum n = sum $ map digitToInt $ show n

isComposite :: Int -> Bool
isComposite n = (not $ isPrime n ) && n /= 1

isSmithNumber :: Int -> Bool
isSmithNumber n = digitSum == factorSum
where
  digitSum :: Int
  digitSum = findDigitSum n
  factorSum :: Int
  factorSum = sum $ map (\l -> (findDigitSum $ head l ) * ( length l ) )
  $ group $ myFactors n

solution :: [Int]
solution = take 10 $ filter (\i -> isComposite i && isSmithNumber i )
[1 , 2 .. ]
