{-# LANGUAGE ScopedTypeVariables #-}
module Challenge138_2
  where
import Data.List( subsequences , nub )
import Data.List.Split ( splitPlaces )
import Data.Char ( digitToInt )

keepAskingForPerfectSquare :: IO Int
keepAskingForPerfectSquare = do
  putStrLn "Please enter a perfect square!" ;
  n <- getLine ;
  let ( number :: Int ) = read n
      root = sqrt $ fromIntegral number
  if (fromIntegral $ floor root) == root
  then return number
  else do
      keepAskingForPerfectSquare

findCombinations :: Int -> [Int]
findCombinations n = concat $ map (\i -> take ( div len i ) $ repeat i )
[1 .. len - 1]
where
  len :: Int
  len = length $ show n

findSuitableCombinations :: Int -> [[Int]]
findSuitableCombinations n = nub $ filter ( (== len ) . sum ) $
filter (\li -> (length li > 1) && ( length li < len ))
theSequences
where
  len :: Int
  len = length $ show n
  theSequences :: [[Int]]
  theSequences = subsequences $ findCombinations n

reverseCombis :: [[Int]] -> [[Int]]
reverseCombis list = map reverse list

findAllCombis :: Int -> [[Int]]
findAllCombis n = theCombis ++ reverseCombis theCombis
where
  theCombis :: [[Int]]
  theCombis = findSuitableCombinations n

findPossibleSplits :: Int -> [[Int]]
findPossibleSplits number = map ( map read ) $ map (\li ->
splitPlaces li numberstring) theSequences
where
  theSequences :: [[Int]]
  theSequences = findAllCombis number
  numberstring :: String
  numberstring = show number

main :: IO ( )
main = do
  num <- keepAskingForPerfectSquare
  let root = floor $ sqrt $ fromIntegral num
      combiSums = map sum $ findPossibleSplits num
  if ((sum $ map digitToInt $ show num ) == root) || (any ( == root ) combiSums)
    then putStrLn "1" else putStrLn "0"
