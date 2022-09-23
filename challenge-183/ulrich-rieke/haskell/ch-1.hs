{-#LANGUAGE ScopedTypeVariables #-}
module Challenge183
  where
import Data.List.Split ( chunksOf )
import qualified Data.Set as S

main :: IO ( )
main = do
  putStrLn "Enter an even number of integers!"
  input <- getLine
  let (numbers :: [Int]) = map read $ words input
      pairs = chunksOf 2 numbers
      uniquePairs = S.toList $ S.fromList pairs
  print uniquePairs
