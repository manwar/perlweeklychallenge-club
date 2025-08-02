import Data.List (sort)

targetIndex :: [Int] -> Int -> [Int]
targetIndex ints k
    = map fst
    $ filter ((k ==) . snd)
    $ zip [0 ..]
    $ sort ints

main :: IO ()
main = do
    print $ targetIndex [1, 5, 3, 2, 4, 2] 2
    print $ targetIndex [1, 2, 4, 3, 5]    6
    print $ targetIndex [5, 3, 2, 4, 2, 1] 4
