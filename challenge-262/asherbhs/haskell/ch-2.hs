countEqualDivisible :: [Int] -> Int -> Int
countEqualDivisible ints k =
  let
    help :: [(Int, Int)] -> Int
    help [] = 0
    help ((x, i) : rest)
        = help rest
        + (length $ filter
            (\(y, j) -> x == y && (i `mod` k == 0 || j `mod` k == 0))
            rest
        )
  in
    help $ zip ints [0 ..]

main :: IO ()
main = do
    print $ countEqualDivisible [3, 1, 2, 2, 2, 1, 3] 2
    print $ countEqualDivisible [1, 2, 3]             1
