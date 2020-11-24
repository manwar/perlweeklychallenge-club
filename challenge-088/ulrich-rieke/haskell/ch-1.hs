module Challenge088
  where
import Data.List ( (!!) )
solution :: [Int] -> [Int]
solution list = [prod `div` ( list !! i ) | i <- [0 .. length list - 1]]
      where
    prod :: Int
    prod = product list
