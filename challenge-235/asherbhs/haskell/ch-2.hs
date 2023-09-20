#!/usr/bin/env runhaskell

duplicateZeros :: [Int] -> [Int]
duplicateZeros xs = take (length xs) $ dup xs
  where
    dup []       = []
    dup (0 : xs) = 0 : 0 : dup xs
    dup (x : xs) = x : dup xs

main :: IO ()
main = do
    print $ duplicateZeros [1, 0, 2, 3, 0, 4, 5, 0]
    print $ duplicateZeros [1, 2, 3]
    print $ duplicateZeros [0, 3, 0, 4, 5]
