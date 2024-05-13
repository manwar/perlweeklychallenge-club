bitwiseOr :: [Int] -> Bool
bitwiseOr = (>= 2) . length . filter (\x -> mod x 2 == 0)

main :: IO ()
main = do
    print $ bitwiseOr [1, 2, 3, 4, 5]
    print $ bitwiseOr [2, 3, 8, 16]
    print $ bitwiseOr [1, 2, 5, 7, 9]
