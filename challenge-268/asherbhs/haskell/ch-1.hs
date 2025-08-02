magicNumber :: [Int] -> [Int] -> Int
magicNumber x y = minimum y - minimum x

main :: IO ()
main = do
    print $ magicNumber [3, 7, 5] [9, 5, 7]
    print $ magicNumber [1, 2, 1] [5, 4, 4]
    print $ magicNumber [2]       [5]
