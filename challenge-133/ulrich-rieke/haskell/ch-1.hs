module Challenge133
  where

solution :: Int -> Int
solution n = fst lastElement
where
  lastElement :: ( Int , Int )
  lastElement = last $ takeWhile ( ( <= n ) . snd ) $ map (\i -> ( i , i ^ 2 ) )
  [0 .. n]
