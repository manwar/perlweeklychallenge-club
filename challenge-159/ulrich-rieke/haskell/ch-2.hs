module Challenge159_2
  where
import Control.Monad.State.Lazy
import Data.List ( nub )

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

keepAskingForInput :: IO Int
keepAskingForInput = do
  putStrLn "Please enter a number greater than 0!"
  number <- getLine
  if ( read number ) > 0 then return $ read number
  else do
      keepAskingForInput

solution :: Int -> Int
solution n
  |len1 == len2 && even len1 = 1
  |len1 == len2 && odd len1 = -1
  |otherwise = 0
  where
      factors :: [Int]
      factors = myFactors n
      len1 :: Int
      len1 = length factors
      len2 :: Int
      len2 = length $ nub factors

main :: IO ( )
main = do
  n <- keepAskingForInput
  putStrLn $ show $ solution n
