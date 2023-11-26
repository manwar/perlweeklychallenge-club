module Challenge244
   where
import Data.List ( (!!) ) 

solution :: [Int] -> [Int]
solution list = map (\i -> length $ filter (\n -> n < ( list !! i ) ) list )
 [0..length list - 1]  
   
