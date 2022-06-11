module Challenge159
  where
import Control.Applicative
import Data.List ( sortBy )

keepAskingForInput :: IO Int
keepAskingForInput = do
  putStrLn "Please enter a number greater than 0!"
  number <- getLine
  if ( read number ) > 0 then return $ read number
  else do
      keepAskingForInput

solution :: Int -> [String]
solution n =
  let pairs = (,) <$> [1 .. n - 1] <*> [1 .. n]
      fractions = filter (\p -> (fst p < snd p) && lcm ( fst p ) ( snd p)
    == ( (fst p) * ( snd p ))) pairs
      sorted = sortBy mySorter fractions
  in ["0/1"] ++ map (\p -> (show $ fst p ) ++ "/" ++ ( show $ snd p ))
    sorted ++ ["1/1"]

mySorter :: (Int, Int) -> (Int,Int) -> Ordering
mySorter (a , b ) ( c , d )
  |firstFrac < secondFrac = LT
  |firstFrac == secondFrac = EQ
  |firstFrac > secondFrac = GT
  where
      firstFrac = fromIntegral a / fromIntegral b
      secondFrac = fromIntegral c / fromIntegral d

main :: IO ( )
main = do
  n <- keepAskingForInput
  list <- return $ solution n
  print list
