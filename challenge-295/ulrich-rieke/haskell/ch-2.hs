module Challenge295_2
   where
import Data.List ( findIndex , (!!) , init ) 
import qualified Data.Set as S

convert :: Int -> Int -> [Int]
convert number index = map (\i -> index + i ) [0..number]

findSublists :: [Int] -> [[Int]]
findSublists list = map (\p -> convert ( snd p ) ( fst p ) ) $ 
 zip [0 , 1 ..] ( init list )

findSelected :: [[Int]] -> [([Int] , [Int])]
findSelected list = map (\p -> ([fst p] , snd p) ) $ filter ( (> 1 )
 . length . snd ) $ zip [0 , 1 ..] list
  
coalesce :: ([Int] , [Int]) -> ([Int] , [Int]) -> ([Int] , [Int])
coalesce firstPair secondPair =
   let firstSet = S.fromList $ snd firstPair
       secondSet = S.fromList $ snd secondPair 
       intersect = S.intersection firstSet secondSet
   in if not $ S.null intersect then (S.toList $ S.fromList (fst firstPair
    ++ fst secondPair ) , S.toList $ S.union firstSet secondSet ) else
     secondPair

condition :: ([Int] , [Int]) -> Int -> Bool
condition pair l = and [ elem 0 p , elem l p]
 where
  p = snd pair

solution :: [Int] -> Int
solution list 
   |head list == 0 = -1
   |head list >= l - 1 = 1
   |otherwise = case findIndex (\p -> condition p ( l - 1 )) finalList of
     Just n -> length $ fst ( finalList !! n )
     Nothing -> -1
    where
      l :: Int
      l = length list
      converted :: [[Int]]
      converted = findSublists list
      selected :: [([Int] , [Int])]
      selected = findSelected converted
      finalList :: [([Int] , [Int] ) ]
      finalList = scanl1 coalesce selected

main :: IO ( )
main = do
   putStrLn "Enter some positive integers separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline
