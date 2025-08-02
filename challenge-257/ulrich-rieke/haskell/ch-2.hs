module Challenge257_2
   where
import Data.List ( transpose , sortOn , findIndices , (!!))
import Data.List.Split ( divvy )

findLeadingNonNull :: [[Int]] -> [(Int , [Int] )]
findLeadingNonNull block = map (\p -> (fst p , findIndices (/= 0 ) $ block !! (
 fst p ) )) $ zip [0, 1 ..] block

hasLeadingOne :: [[Int]] -> Bool
hasLeadingOne block = null pairs || all (\p -> ( block !! ( fst p )
 !! ( head $ snd p )) == 1 ) pairs 	 
 where
  pairs = filter ( not . null . snd ) $ findLeadingNonNull block

zeroesAtBottom :: [[Int]] -> Bool
zeroesAtBottom block = null nulls || maximum_nonNulls < minimum_nulls
 where
  allNull :: [Int] -> Bool
  allNull row = all ( == 0 ) row
  pairs :: [(Int , [Int])]
  pairs = zip [0,1..] block
  nonNulls :: [(Int , [Int])]
  nonNulls = sortOn fst $ filter ( not. allNull . snd ) pairs
  nulls :: [(Int , [Int] )]
  nulls = sortOn fst $ filter ( allNull . snd ) pairs
  maximum_nonNulls :: Int
  maximum_nonNulls = fst $ last $ nonNulls 
  minimum_nulls ::Int
  minimum_nulls = fst $ head $ nulls 

hasStackedOnes :: [[Int]] -> Bool
hasStackedOnes matrix =
  let pairs = filter ( not . null . snd ) $ findLeadingNonNull matrix
      leadingOnes = filter (\p -> (matrix !! ( fst p ) !! ( head $ snd p )) == 1 ) 
       pairs 
      positions = map ( head . snd ) leadingOnes 
      myP = length positions  
  in null pairs || myP == 1 || ( if myP == 2 then ( positions !! 1 )
   > ( positions !! 0 ) else all (\subli -> last subli > head subli ) $ divvy
   2 1 positions )
       
leadingOnesAllNullCol :: [[Int]] -> Bool
leadingOnesAllNullCol matrix = 
 let pairs = filter ( not . null . snd ) $ findLeadingNonNull matrix
     leadingOnes = filter (\p -> (matrix !! ( fst p ) !! ( head $ snd p )) == 1 ) 
      pairs 
     positions = map ( head . snd ) leadingOnes 
     transposed = transpose matrix
     l = length matrix 
 in null pairs || all (\col -> (length $ findIndices (== 0)  (transposed !! col))
  == l - 1 ) positions

condition :: [[Int]] -> Bool
condition matrix = leadingOnesAllNullCol matrix && hasStackedOnes matrix 
 && zeroesAtBottom matrix && hasLeadingOne matrix

getMatrix :: IO [String]
getMatrix = do
   line <- getLine
   if not $ null line then do
    restOfLines <- getMatrix
    return ( line : restOfLines )
   else do
    return []

main :: IO ( )
main = do
   putStrLn "Enter some integers, separated by blanks!" 
   putStrLn "Enter <return> to end entry!"
   matrix <- getMatrix
   let numbers = map ( map read . words ) matrix
   --print $ leadingOnesAllNullCol numbers
   if condition numbers then print 1 else print 0
