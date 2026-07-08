strip :: [Int] -> Int
strip s = cnt
  where cnt = length o
        o = filter (/= m1) $ filter (/= m2) s
        m1 = maximum s
        m2 = minimum s
  
main = do
  let input = [[2,4], [1,1,1,1], [1,1,4,8,12,12], [3,6,6,9], [0, -5, 10, -2, 4]]
  mapM_ proc input
    where
      proc s = do
        putStrLn ("Input: " ++ show s)
        let out = strip s
        putStrLn ("Output: " ++ show out)
