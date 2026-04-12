
makeItBigger :: String -> Char -> String
makeItBigger str char = show $
                        foldl1 max $
                        map (read :: String -> Integer) $
                        perms str ""
    where
        perms :: String -> String -> [String]
        perms [] acc = []
        perms (x:xs) acc
            | x == char = (acc++xs): perms xs (acc++[x])
            | otherwise = perms xs (acc++[x])


main :: IO ()
main = do
    print $ (makeItBigger "15456" '5')  == "1546"
    print $ (makeItBigger "7332" '3')   == "732"
    print $ (makeItBigger "2231" '2')   == "231"
    print $ (makeItBigger "543251" '5') == "54321"
    print $ (makeItBigger "1921" '1')   == "921"
