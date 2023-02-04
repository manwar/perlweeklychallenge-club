module Challenge202_2
  where
import Data.List.Split ( divvy )
import Data.List ( sortOn , sortBy )

isValidList :: [Int] -> Bool
isValidList list = all ( >= 0 ) second
where
  differences :: [Int]
  differences = map (\li -> last li - head li ) $ divvy 2 1 list
  second :: [Int]
  (_ , second ) = span ( <= 0 ) differences

findLargestValidSublist :: [Int] -> [Int]
findLargestValidSublist list = last $ sortOn length $ filter isValidList
$ [take n list | n <- [2..length list ]]

findIndexedSublists :: [Int] -> [(Int , [Int]) ]
findIndexedSublists list = zip [0 .. l - 2] ( map (\i ->
findLargestValidSublist $ drop i list ) [0..l - 2] )
where
  l :: Int
  l = length list

mySorter :: (Int , [Int] ) -> (Int , [Int] ) -> Ordering
mySorter ( a , aList ) ( b , bList )
  |length aList > length bList = LT
  |length aList == length bList = compare a b
  |length aList < length bList = GT

findOrderedSublists :: [(Int , [Int] )] -> [(Int , [Int])]
findOrderedSublists allLists = sortBy mySorter allLists

main :: IO ( )
main = do
  putStrLn "Enter some integers , separated by blanks!"
  numberstrings <- getLine
  let numbers = map read $ words numberstrings
      indexedSublists = findIndexedSublists numbers
      orderedLists = findOrderedSublists indexedSublists
  print $ snd $ head orderedLists
