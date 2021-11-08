module Challenge124_2
  where
import qualified Data.Set as Set
import Data.List ( minimumBy , sort )

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ xs !! i : x | i <- [0..(length xs ) - 1 ] ,
x <- combinations (n - 1 ) ( drop ( i + 1 ) xs ) ]

findComplement :: [Int] -> [Int] -> [Int]
findComplement numbers combi = Set.toList ( Set.fromList numbers Set.\\
Set.fromList combi )

solution :: [Int] -> String
solution list = "Subset 1 = " ++ (show $ sort $ fst pair) ++ " " ++
"Subset 2 = " ++ ( show $ sort $ snd pair )
where
  pair :: ([Int] , [Int] )
  pair =  minimumBy myFunc listPairs
  l :: Int
  l = length list
  allCombis :: [[Int]]
  allCombis = if even l then combinations ( div l 2 ) list else
  (combinations ( div l 2 ) list) ++ ( combinations ( div l 2 + 1 ) list)
  listPairs :: [( [Int] , [Int] )]
  listPairs = map (\combi -> ( combi , findComplement list combi ) )
  allCombis
  myFunc :: ([Int] , [Int] ) -> ([Int] , [Int] ) -> Ordering
  myFunc pair1 pair2
  | abs ( (sum $ fst pair1) - (sum $ snd pair1) ) <  abs ( (sum $ fst pair2
    ) - (sum $ snd pair2) ) = LT
  | abs ( (sum $ fst pair1) - (sum $ snd pair1) ) == abs ( (sum $ fst pair2
    ) - (sum $ snd pair2) ) = EQ
  | abs ( (sum $ fst pair1) - (sum $ snd pair1) ) > abs ( (sum $ fst pair2
    ) - (sum $ snd pair2) ) = GT
