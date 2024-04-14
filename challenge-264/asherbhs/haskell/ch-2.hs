import Data.List (sortOn)

targetArray :: [Int] -> [Int] -> [Int]
targetArray source indices
    = map fst
    $ sortOn snd
    $ zip source
    $ trueIndices indices
  where
    trueIndices :: [Int] -> [Int]
    trueIndices [] = []
    trueIndices (i : is)
        = i + length (filter (i >=) is)
        : trueIndices is

main :: IO ()
main = do
    print $ targetArray [0, 1, 2, 3, 4] [0, 1, 2, 2, 1]
    print $ targetArray [1, 2, 3, 4, 0] [0, 1, 2, 3, 0]
    print $ targetArray [1]             [0]
