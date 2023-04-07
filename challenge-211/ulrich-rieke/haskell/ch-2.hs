module Challenge211_2
  where
import Data.List ( (\\) )

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] ,
x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]

subAction :: [Int] -> [Int] -> ([Int] , [Int] )
subAction totalList aCombination = (aCombination , totalList \\ aCombination)

solution :: [Int] -> Bool
solution list
  |l == 1 = True
  |l == 2 = head list == last list
  |l > 2 = any (\(l1 , l2) -> average l1 == average l2 ) $ map
    (\sublist -> subAction list sublist ) $ concat $ map
    (\i -> combinations i list ) [div ( l - 1 ) 2 .. l - 1]
    where
    average :: [Int] -> Double
    average someList = (fromIntegral $ sum someList ) / ( fromIntegral $ length
      someList )
    l      :: Int
    l      = length list

main :: IO ( )
main = do
  putStrLn "Please enter some integers, separated by blanks!"
  numberstrings <- getLine
  let numbers = map read $ words numberstrings
  if solution numbers then print "true" else print "false"
