module Challenge193
  where

toBinaryVec :: Int -> Int -> [Int]
toBinaryVec num len = replicate ( len - length result ) 0 ++ result
where
  result :: [Int]
  result = snd $ until ( (== 0) . fst ) step ( num , [] )
  step :: (Int , [Int] ) -> ( Int , [Int] )
  step ( d , li ) = ( div d 2 , mod d 2 : li )

findLimit :: Int -> Int
findLimit n = sum $ map (\p -> fst p * snd p ) $ zip ( iterate ( * 2 ) 1 )
( replicate n 1 )

solution :: Int -> [String]
solution n = map (\vec -> foldl1 ( ++ ) $ map show vec ) $ map (\i ->
toBinaryVec i n ) [0..findLimit n]
