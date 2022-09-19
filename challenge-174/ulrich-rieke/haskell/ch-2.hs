module Challenge174_2
  where
import Data.List ( permutations , sortOn , findIndex )
import Data.Maybe ( fromJust )

toString :: [Int] -> String
toString = foldl1 ( ++ ) . map show

permutation2rank :: [Int] -> Int
permutation2rank list = fromJust $ findIndex ( (== list) . fst ) $
sortOn snd $ map (\li -> ( li , toString li )) $ permutations list

rank2permutation :: [Int] -> Int -> [Int]
rank2permutation list n = fst $ head $ drop n $ sortOn snd $ map (\li ->
( li , toString li ) ) $ permutations list
