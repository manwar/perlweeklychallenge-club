module Challenge192_2
  where
import Data.List ( findIndex , (!!) )
import Data.Maybe ( fromJust ) 

solution :: [Int] -> Int
solution list
  |mod ( sum list ) ( length list ) /= 0 = -1
  |all (\i -> i == head list ) list = 0
  |otherwise = fst $ until ( myCondition . snd ) step ( 0 , list )
  where
    myCondition :: [Int] -> Bool
    myCondition li = all (\n -> n == head li ) li
    step :: ( Int , [Int] ) -> ( Int , [Int] )
    step (d , l ) = ( d + 1 , transform l )

compareNeighbours :: Int -> Int -> [Int] -> [Int]
compareNeighbours maxIndex minIndex list
  |list !! ( maxIndex - 1 ) < list !! ( maxIndex + 1 ) = take ( maxIndex
    - 1 ) list ++ [ list !! ( maxIndex - 1 ) + 1 ] ++ [list !! maxIndex - 1]
    ++ drop ( maxIndex + 1 ) list
  |list !! ( maxIndex - 1 ) > list !! ( maxIndex + 1 ) = take maxIndex list
    ++ [ list !! maxIndex - 1 ] ++ [ list !! ( maxIndex + 1 ) + 1 ] ++
    drop ( maxIndex + 2 ) list
  |otherwise = if minIndex < maxIndex then take ( maxIndex - 1 ) list ++
    [ list !! ( maxIndex - 1 ) + 1 ] ++ [ list !! maxIndex - 1 ] ++ drop
    ( maxIndex + 1 ) list else take maxIndex list ++ [ list !! maxIndex - 1 ]
    ++ [ list !! ( maxIndex + 1 ) + 1 ] ++ drop ( maxIndex + 2 ) list
 
transform :: [Int] -> [Int]
transform list
  |maxIndex == 0 = [head list - 1 ] ++ [list !! 1 + 1 ] ++ drop 2 list
  |maxIndex == l - 1 = take ( l - 2 ) list ++ [ list !! ( l - 2 ) + 1 ] ++
    [last list - 1]
  |otherwise = compareNeighbours maxIndex minIndex list
    where
      l :: Int
      l = length list
      maxi :: Int
      maxi = maximum list
      maxIndex :: Int
      maxIndex = fromJust $ findIndex ( == maxi ) list
      mini :: Int
      mini = minimum list
      minIndex :: Int
      minIndex = fromJust $ findIndex ( == mini ) list

main :: IO ( )
main = do
  putStrLn "Enter some integers greater than or equal to 0!"
  numberline <- getLine
  print $ solution $ map read $ words numberline
