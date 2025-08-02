module Challenge254
   where
import Data.Ratio

third :: Ratio Int
third = 1 % 3 

solution :: Int -> Bool
solution n = ( fromIntegral $ floor cuberoot ) == cuberoot
 where
  cuberoot = (fromIntegral n ) ** ( realToFrac third )
