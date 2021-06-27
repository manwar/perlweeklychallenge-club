module Challenge118
  where
import Control.Monad.State.Lazy
import Data.Char ( intToDigit )

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

solution :: Integer -> Int
solution n
  |reverse binarystring == binarystring = 1
  |otherwise = 0
  where
    binarystring :: String
    binarystring = map ( intToDigit . fromInteger ) $ evalState toBase ([] , n , 2 )
