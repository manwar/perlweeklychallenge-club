module Challenge089
  where
import Data.List ( subsequences )

solution :: Int -> Int
solution n = sum $ map (\li -> gcd (head li) ( last li )) $ filter ( (2 == ) . length )
  $ subsequences [1..n]
