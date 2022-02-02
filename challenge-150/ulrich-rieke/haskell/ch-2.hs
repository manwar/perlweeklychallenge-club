module Challenge150_2
  where
import Control.Monad.State.Lazy
import Data.List ( nub )

divisors :: Int -> [Int]
divisors n = [p | p <- [2 .. n] , mod n p == 0]

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

isSquareFree :: Int -> Bool
isSquareFree num
  |num == 1 = True
  |otherwise = length list == ( length $ nub list )
    where
      list :: [Int]
      list = myFactors num

solution :: [Int]
solution = filter isSquareFree [1 .. 500]
