module Challenge082_2
  where

myCondition :: String -> String -> String -> Bool
myCondition a b c
  |length a == length b = (foldl1 ( ++ ) (zipWith glue  a b) == c) ||
    (foldl1 ( ++ ) (zipWith glue b a) == c)
  |length a /= length b = ((foldl1 ( ++ ) $ zipWith glue smaller ( take sl greater ))
    ++ (drop sl greater)) == c || ((foldl1 ( ++ ) $ zipWith glue ( take sl greater )
    smaller) ++ (drop sl greater )) == c
      where
    greater :: String
    greater
      |length a > length b = a
      |otherwise          = b
    smaller :: String
    smaller
      |length a < length b = a
      |otherwise          = b
    sl :: Int
    sl = length smaller

solution :: String -> String -> String -> Int
solution a b c
  |myCondition a b c = 1
  |otherwise        = 0

glue :: Char -> Char -> String
glue a b = [a] ++ [b]
