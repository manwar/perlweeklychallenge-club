module Challenge188_2
  where
import Data.List.Split ( splitOn )

solution :: (Int , Int ) -> Int
solution p
  |fst p == snd p = 1
  |otherwise = fst $ until (\p -> (fst $ snd p) == (snd $ snd p)) step (1 , p )
    where
    step :: ( Int , (Int , Int)) -> (Int, (Int , Int))
    step ( count , ( x , y )) = if x > y then ( count + 1 , ( x - y , y )) else
      ( count + 1 , ( x , y - x ))

main :: IO ( )
main = do
  putStrLn "Enter 2 integers, separated by a blank!"
  numbers <- getLine
  let integers = map read $ splitOn " " numbers
      nums = ( head integers , last integers )
  print $ solution nums
