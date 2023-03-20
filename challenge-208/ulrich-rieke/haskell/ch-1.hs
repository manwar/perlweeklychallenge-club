module Challenge208
  where
import Data.List ( findIndex , sortOn)
import Data.Maybe ( fromJust )
import qualified Data.Set as S

findCommonWords :: [String] -> [String] -> [String]
findCommonWords firstList secondList = S.toList $ S.intersection
(S.fromList firstList) (S.fromList secondList)

findStringPositions :: [String] -> [String] -> [(String , Int)]
findStringPositions firstList secondList
  |not $ null commonWords = map (\s -> (s, (fromJust $ findIndex (== s)
    firstList) + ( fromJust $ findIndex ( == s ) secondList ))) commonWords
  |null commonWords = []
  where
    commonWords :: [String]
    commonWords = findCommonWords firstList secondList

solution :: [String] -> [String] -> [String]
solution listA listB
  |not $ null positions = map fst $ filter ((== minim ) . snd ) sorted
  |otherwise = []
  where
    positions :: [(String , Int)]
    positions = findStringPositions listA listB
    sorted    :: [(String , Int)]
    sorted    = sortOn snd positions
    minim    :: Int
    minim    = snd $ head sorted

main :: IO ( )
main = do
  putStrLn "Enter some strings, separated by blanks!"
  firstLine <- getLine
  putStrLn "Enter some more strings, separated by blanks!"
  secondLine <- getLine
  let firstWords = words firstLine
      secondWords = words secondLine
      sol = solution firstWords secondWords
  if not $ null sol
  then print sol
  else print "()"
