module Challenge252_2
   where

solution :: Int -> [Int]
solution n
   |odd n = [-limit..limit]
   |even n = first_part ++ [0 - sum first_part]
    where
     limit = div n 2
     first_part = take ( n - 1 ) $ iterate ( + 1 ) (limit * ( -1 ) )
