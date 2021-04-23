module Challenge104
  where
import Data.List ( (!!) )

myFunc :: (Int, [Int]) -> (Int , [Int] )
myFunc ( n , list )
  |even (n + 1 ) = (n + 1 , list ++ [list !! half])
  |otherwise = (n + 1 , list ++ [ (list !! half ) + (list !! (half + 1 ) ) ] )
  where
      half :: Int
      half = div (n + 1 ) 2

solution :: [Int]
solution = snd $ last $ take 49 $ iterate myFunc ( 1 , [0,1])
