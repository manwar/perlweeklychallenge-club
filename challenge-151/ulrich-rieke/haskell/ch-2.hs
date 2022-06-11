module Challenge151_2
  where
import Data.List.Split ( divvy , splitOn )
import Data.List ( (!!) , subsequences )

-- no difference greater than 1
fulfillsCondition :: [Int] -> Bool
fulfillsCondition list = all (\l -> abs ( head l - last l) > 1 ) $ divvy 2 1 list

--find all those indexes in the list of numbers entered that are not
--neighbouring
findSuitableIndices :: Int -> [[Int]]
findSuitableIndices len
  |even len = filter fulfillsCondition $ filter ( (== ( div len 2 )) . length )
    theList
  |odd len = filter fulfillsCondition (filter ( (== div len 2 + 1 ) . length ) theList ++
    ( filter (( == div len 2 ) . length ) theList))
  where
    theList :: [[Int]]
    theList = subsequences [0 .. len - 1]

--from the list of numbers entered find those sublists that are not
--neighbouring
findSublists :: [Int] -> [[Int]] -> [[Int]]
findSublists list possibleIndices = map (\l -> map (\i -> list !! i) l )
possibleIndices

solution :: [Int] -> Int
solution list
  |l == 1 = head list
  |l == 2 = maximum list
  |l == 3 = if head list + last list > list !! 1 then head list + last list else
            list !! 1
  |l > 3 = maximum $ map sum $ findSublists list ( findSuitableIndices l )
  where
    l :: Int
    l = length list

main :: IO ( )
main = do
  putStrLn "Please enter a row of integers, separated by a space!" ;
  input <- getLine ;
  let numbers = fmap read $ splitOn " " input
  putStrLn $ show $ solution numbers
