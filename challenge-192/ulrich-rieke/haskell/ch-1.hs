module Challenge192
  where

toBinaries :: Int -> [ Int ]
toBinaries n = snd $ until ( ( == 0 ) . fst ) step ( n , [] )
where
  step :: ( Int , [Int] ) -> ( Int , [Int] )
  step ( d , li ) = ( div d 2 , mod d 2 : li )

myFlip :: [Int] -> [Int]
myFlip list = map (\i -> if i == 1 then 0 else 1 ) list

toDecimal :: [Int] -> Int
toDecimal list = sum $ map (\p -> fst p * snd p ) $ zip ( iterate ( * 2 ) 1 )
( reverse list )

solution :: Int -> Int
solution = toDecimal . myFlip . toBinaries
