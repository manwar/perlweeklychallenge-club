dot_product :: [Int] -> [Int] -> Int
dot_product [x] [y]       = x * y
dot_product (x:xs) (y:ys) = (x * y) + dot_product (xs) (ys)
