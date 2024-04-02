import qualified Data.Map as Map

mergeItems :: [[Int]] -> [[Int]] -> [[Int]]
mergeItems items1 items2
    = map (\(k, v) -> [k, v])
    $ Map.toList
    $ Map.fromListWith (+)
    $ map (\[k, v] -> (k, v))
    $ items1 ++ items2

main :: IO ()
main = do
    print $ mergeItems
        [[1, 1], [2, 1], [3, 2]]
        [[2, 2], [1, 3]]
    print $ mergeItems
        [[1, 2], [2, 3], [1, 3], [3, 2]]
        [[3, 1], [1, 3]]
    print $ mergeItems
        [[1, 1], [2, 2], [3, 3]]
        [[2, 3], [2, 4]]
