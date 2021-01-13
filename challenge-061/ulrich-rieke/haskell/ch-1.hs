module Challenge061
  where
import Data.List ( sortOn )

findSublist :: Int -> Int -> [a] -> [a]
findSublist from to list = take ( to - from ) $ drop from list

allcontiguousSublists :: [Int] -> [[Int]]
allcontiguousSublists numbers = [ findSublist start end numbers | start
<- [0..len - 1 ], end <- [start + 1..len]]
where
  len = length numbers

findMaximumSublist :: [Int] -> (Int, [Int] )
findMaximumSublist numbers =
  let contiguous = allcontiguousSublists numbers
      productlist = map (\li -> ( product li , li )) contiguous
  in  last $ sortOn fst productlist
