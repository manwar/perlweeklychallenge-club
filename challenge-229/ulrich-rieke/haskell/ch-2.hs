module Challenge229_2
   where
import qualified Data.Set as S
import Data.List( (!!) , sort )

solution :: [[Int]] -> [Int]
solution allLines = sort $ S.toList $ foldl1 S.union [ firstIntersect , 
 secondIntersect , thirdIntersect]	 
  where
   sets :: [S.Set Int]
   sets = map S.fromList allLines
   firstIntersect :: S.Set Int
   firstIntersect = S.intersection ( sets !! 0 ) ( sets !! 1 )
   secondIntersect :: S.Set Int
   secondIntersect = S.intersection ( sets !! 1 ) ( sets !! 2 ) 
   thirdIntersect :: S.Set Int
   thirdIntersect = S.intersection ( sets !! 0 ) ( sets !! 2 )

decompose :: String -> [Int]
decompose s = map read $ words s

main :: IO ( ) 
main = do 
   putStrLn "Enter three lines of integers, separated by blanks each!"
   firstLine <- getLine
   secondLine <- getLine
   thirdLine <- getLine
   let theLines = [decompose firstLine , decompose secondLine , decompose 
                  thirdLine]
   print $ solution theLines 
