module Challenge114_2
  where
import Control.Monad.State.Lazy

--using a state monad that computes a list of integers to convert to a
--given base

toBase :: State ([Integer] , Integer , Integer ) [Integer]
toBase  = do
  ( basenumbers , num , base ) <- get
  if num == 0
      then
    return basenumbers
      else do
    put ( mod num base : basenumbers , div num base , base )
        toBase

baseNumbers :: Integer -> Integer -> [Integer]
baseNumbers n b = evalState toBase ( [] , n , b )

count :: Eq a => a -> [a] -> Int
count c list = length $ filter ( == c ) list

solution :: Integer -> Integer
solution n = head $ dropWhile (\i -> (count 1 $ baseNumbers i 2) /= ones )
[n + 1 , n + 2 ..]
where
  ones :: Int
  ones = count 1 $ baseNumbers n 2
