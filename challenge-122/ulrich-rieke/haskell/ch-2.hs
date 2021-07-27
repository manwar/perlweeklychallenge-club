module Challenge122_2
  where
import Data.List ( permutations )
import qualified Data.Set as S

findRepetitions :: Int -> Int -> Int
findRepetitions num total = div total num

findSomeLists :: [Int] -> Int -> [[Int]]
findSomeLists points total = concat $ map createList points
where
  createList :: Int -> [[Int]]
  createList i = [take howoften $ repeat i | howoften <-
  [1 .. findRepetitions i total]]

makeAllLists :: Int -> [[Int]] -> [[Int]]
makeAllLists total possibleLists = [ lista ++ listb |
lista <- possibleLists , listb <- possibleLists , sum ( lista ++ listb )
  == total ]

solution :: Int -> [[Int]]
solution n = S.toList $ S.fromList $ concat $ map permutations totalList
where
  basketball :: [Int]
  basketball = [1 , 2 , 3]
  someLists :: [[Int]]
  someLists = findSomeLists basketball n
  totalList :: [[Int]]
  totalList = makeAllLists n someLists
