orderGame :: [Int] -> Int
orderGame ints = head $ foldr
    (\_ ints -> zipWith
        ($)
        (cycle $ map uncurry [min, max])
        (pairUp ints)
    )
    ints
    [1 .. logBase 2 $ fromIntegral $ length ints]
  where
    pairUp :: [a] -> [(a, a)]
    pairUp [] = []
    pairUp (x : y : xs) = (x, y) : pairUp xs


main :: IO ()
main = do
    print $ orderGame [2, 1, 4, 5, 6, 3, 0, 2]
    print $ orderGame [0, 5, 3, 2]
    print $ orderGame [9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]
