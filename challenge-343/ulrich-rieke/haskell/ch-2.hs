module Challenge343_2
   where
import Data.List( sortBy , (!!) )

getSomeLines :: IO [String]
getSomeLines = do
   line <- getLine
   if null line then return []
   else
    (line : ) <$> getSomeLines

toMatrix :: [String] -> [(Int , [Int])]
toMatrix input = zip [0 , 1 ..] ( map ( map read . words ) input )

mySorter :: (Int , [Int]) -> (Int , [Int]) -> Ordering
mySorter firstPair secondPair = 
   let firstOnes = length $ filter ( == 1 ) $ snd firstPair
       secondOnes = length $ filter ( == 1 ) $ snd secondPair
   in if firstOnes /= secondOnes then compare firstOnes secondOnes else
   if ( snd firstPair ) !! ( fst secondPair ) == 0 then LT else GT

main :: IO ( ) 
main = do
   putStrLn "Enter n lines of n 0 and 1 , enter <return> to end!"
   allLines <- getSomeLines
   let matrix = toMatrix allLines
   putStrLn ("Team " ++ show  (fst $ last $ sortBy mySorter matrix))
