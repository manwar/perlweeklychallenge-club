module Challenge223_2
  where
import Data.Maybe( fromJust )
import Data.List ( findIndex , (!!) , findIndices , sortBy )

dropElement :: [Int] -> Int -> [Int]
dropElement list pos = take pos list ++ drop ( pos + 1 ) list

multiplyNeighbours :: [Int] -> Int -> Int
multiplyNeighbours list pos
  |pos == 0 = (list !! 0)  * (list !! 1)
  |pos == l - 1 = ( list !! ( l - 1 ) ) * (list !! (l - 2 ) )
  |otherwise = (list !! ( pos - 1 )) * (( list !! pos ) * ( list !! ( pos + 1 )))
  where
    l :: Int
    l = length list

findElementforDrop :: [Int] -> Int
findElementforDrop list
  |l == 2 = fromJust $ findIndex ( == min ( head list ) ( last list ) ) list
  |l == 3 = 1
  |l > 3 = if length minilist == 1 then head minilist else last $
    sortBy (\a b -> compare (multiplyNeighbours list a )
    (multiplyNeighbours list b ) ) minilist
    where
      mini :: Int
      mini = minimum list
      minilist :: [Int]
      minilist = findIndices ( == mini ) list
      l        :: Int
      l        = length list

solution :: [Int] -> Int
solution list
  |length list == 1 = head list
  |otherwise =  fst result + ( head $ snd result )
  where
    result :: ( Int , [Int] )
    result =  until ( (== 1 ) . length . snd ) step (0 , list)
    step :: (Int , [Int] ) -> (Int , [Int])
    step (aSum , someList ) = ( aSum + multiplyNeighbours someList found ,
    dropElement someList found )
    where
      found :: Int
      found = findElementforDrop someList

main :: IO ( )
main = do
  putStrLn "Enter some integers separated by blanks!"
  numberstrings <- getLine
  let numbers = map read $ words numberstrings
  print $ solution numbers
