module Challenge397_2
   where
import Data.List ( sortBy )

toReverseBinary :: Int -> [Int]
toReverseBinary number = snd $ until ( (== 0 ) . fst ) step (number , [])
   where
      step :: (Int , [Int]) -> (Int , [Int])
      step ( currentNumber , currentList ) = ( div currentNumber 2 , 
            currentList ++ [mod currentNumber 2] )

toNumber :: [Int] -> Int
toNumber list = sum $ map (\p -> fst p * snd p ) $ map (\p -> (2 ^
 ( fst p ) , snd p )) $ zip ( reverse [0 .. length( list ) - 1] ) list
  


convert :: Int -> Int
convert = toNumber . toReverseBinary

mySorter :: Int -> Int -> Ordering
mySorter a b 
   |fca /= fcb = compare fca fcb
   |otherwise = compare a b
      where
         fca = convert a
         fcb = convert b

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!"
   numberline <- getLine
   print $ sortBy mySorter $ map read $ words numberline
