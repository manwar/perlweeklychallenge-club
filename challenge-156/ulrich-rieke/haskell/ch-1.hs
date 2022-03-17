module Challenge156
  where
import Control.Monad.State.Lazy
import Data.Maybe ( fromJust )
import Data.Char ( intToDigit )

findBases :: Int -> State ( Int , String ) String
findBases theBase = do
  (number , basenumberstring) <- get
  if number == 0
      then return (reverse basenumberstring)
  else do
      put ( div number theBase , basenumberstring ++
            [ fromJust $ lookup ( mod number theBase ) positions ] )
      findBases theBase

convertToBase :: Int -> Int -> String
convertToBase number base = evalState (findBases base ) ( number , [] )

isPrime :: Integer -> Bool
isPrime n
  |n == 1 = False
  |n == 2 = True
  |otherwise = null $ filter (\i -> mod n i == 0 ) [2 .. toInteger root]
  where
      root :: Int
      root = round $ sqrt $ fromIntegral n

positions :: [(Int , Char) ]
positions = zip [0..35] ( (map intToDigit [0..9]) ++ ['A'..'Z'] )

isPernicious :: Int -> Bool
isPernicious n = isPrime $ toInteger $ length $ filter ( == '1' )
$ convertToBase n 2

solution :: [Int]
solution = take 10 $ filter isPernicious [1 , 2 ..]
