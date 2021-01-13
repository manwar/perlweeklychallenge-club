module Challenge077
  where
import Data.List ( nub, subsequences , intercalate)

fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci ( n - 2 ) + fibonacci ( n - 1 )

findList :: Int -> [ Int ]
findList n = nub $ takeWhile ( < n ) $ map fibonacci [1..n]

convert :: [Int] -> String
convert list = (intercalate " + " $ map show list) ++ " = " ++ ( show $
sum list )

solution :: Int -> [String]
solution n = map convert $ filter (( n == ) . sum ) $ subsequences
$ findList n
