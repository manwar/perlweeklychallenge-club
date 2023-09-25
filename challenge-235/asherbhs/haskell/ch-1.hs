#!/usr/bin/env runhaskell

removeOne :: [Int] -> Bool
removeOne xs = or $ map
    (\n ->
      let
        xs' = take n xs ++ drop (n+1) xs
      in
        and $ zipWith (<) xs' $ tail xs'
    )
    [0..length xs - 1]

main :: IO ()
main = do
    print $ removeOne [0, 2, 9, 4, 6]
    print $ removeOne [5, 1, 3, 2]
    print $ removeOne [2, 2, 3]
