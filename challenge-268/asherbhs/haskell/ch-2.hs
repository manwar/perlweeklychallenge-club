import Data.List (sort)

numberGame :: [Int] -> [Int]
numberGame = flipAdjacent . sort
  where
    flipAdjacent :: [Int] -> [Int]
    flipAdjacent [] = []
    flipAdjacent (x : y : t) = y : x : flipAdjacent t

main :: IO ()
main = do
    print $ numberGame [2, 5, 3, 4]
    print $ numberGame [9, 4, 1, 3, 6, 4, 6, 1]
    print $ numberGame [1, 2, 2, 3]

