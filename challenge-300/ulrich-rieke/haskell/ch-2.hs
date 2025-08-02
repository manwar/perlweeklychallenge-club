module Challenge300_2
   where
import qualified Data.Set as S
import Data.List ( (!!) ) 

transform :: [Int] -> Int -> Int 
transform list startindex = (length $ fst $ until condition step ([] ,
 startindex )) - 1
   where
    condition :: ([Int] , Int) -> Bool
    condition (theList , _) = (S.size( S.fromList theList )) /=
     length theList  
    step :: ([Int] , Int) -> ([Int] , Int)
    step (currentList , currentIndex ) = (currentList ++  [list !! 
     currentIndex] , list !! currentIndex )	     

solution :: [Int] -> Int
solution list = maximum $ map (\i -> transform list i ) [0..length list - 1]

main :: IO ( ) 
main = do
   putStrLn "Enter a permutation of integers separated by blanks!" 
   numberLine <- getLine
   print $ solution $ map read $ words numberLine
