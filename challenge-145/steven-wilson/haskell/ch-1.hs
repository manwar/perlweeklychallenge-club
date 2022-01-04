dot_product :: Num a => [a] -> [a] -> a
dot_product [] []         = 0
dot_product (x:xs) (y:ys) = (x * y) + dot_product (xs) (ys)
