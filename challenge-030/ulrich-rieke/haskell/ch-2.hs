solution :: [[Int]]
solution = S.toList $ S.fromList $ map sort $ [[a , b , c] | a <-[1..10] ,
    b <- [1..10] , c <- [1..10] , a + b + c == 12 ,
    any (\i -> even i) [a , b , c]]
