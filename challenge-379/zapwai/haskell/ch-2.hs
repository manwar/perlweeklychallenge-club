digits :: Int -> Int -> [Int]
digits b n
       | n < b = [n]
       | otherwise = digits b (n `div` b) ++ [n `mod` b]

armstrong :: Int -> Int -> Bool
armstrong b num = 
    let d = digits b num
        n = length d
        tot = sum [ x^n | x <- d]
    in tot == num

main = do
     let bases = [10, 7, 16]
     mapM_ (\b -> do
         putStrLn $ "Base " ++ show b ++ ":"
         print $ filter (armstrong b) [1..1000]
         putStrLn ""
           ) bases
