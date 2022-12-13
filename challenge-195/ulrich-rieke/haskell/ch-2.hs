module Challenge195_2
  where
import qualified Data.Set as S
import Data.List ( (!!) , sortOn )

count :: Eq a => a -> [a] -> Int
count el list = length $ filter ( == el ) list

solution :: [Int] -> Int 
solution numbers
  |null uniqueEvens = -1
  |otherwise = if  snd  (pairs !! 0)  /=  snd (pairs !! 1 )  then
    fst (pairs !! 0 ) else smallest
      where
      uniqueEvens :: [Int]
      uniqueEvens = S.toList $ S.fromList $ filter even numbers
      pairs :: [(Int , Int)]
      pairs = reverse $ sortOn snd $ zip uniqueEvens ( map
      (\i -> count i numbers ) uniqueEvens )
      smallest :: Int
      smallest = minimum uniqueEvens
