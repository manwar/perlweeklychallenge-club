module Main where

main :: IO ()
main = print $ summations [1 .. 5]

summations :: [Int] -> Int
summations = untilOneLeft (scanl1 (+) . tail) 0

untilOneLeft :: ([a] -> [a]) -> a -> [a] -> a
untilOneLeft _ d [] = d
untilOneLeft _ _ [a] = a
untilOneLeft aa d as = untilOneLeft aa d (aa as)