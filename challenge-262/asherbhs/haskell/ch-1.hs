{-# LANGUAGE MultiWayIf #-}

maxPositiveNegative :: [Int] -> Int
maxPositiveNegative ints =
  let
    (pos, neg) = foldr
        (\n (pos, neg) -> if
            | n > 0     -> (pos + 1, neg    )
            | n < 0     -> (pos,     neg + 1)
            | otherwise -> (pos,     neg    )
        )
        (0, 0)
        ints
  in
    max pos neg

main :: IO ()
main = do
    print $ maxPositiveNegative [-3, 1, 2, -1, 3, -2, 4]
    print $ maxPositiveNegative [-1, -2, -3, 1]
    print $ maxPositiveNegative [1, 2]
