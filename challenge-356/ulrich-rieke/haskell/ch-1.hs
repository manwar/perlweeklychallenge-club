module Challenge356
   where
import Data.List ( findIndices , (!!) )

kolakoski :: Int -> [Int]
kolakoski num =  snd $ until ( ( >= num )  . length . snd ) step (3 , [1 , 2 , 2] )

step :: (Int , [Int] ) -> (Int , [Int] ) 
step ( aNum , aList ) = (aNum + 1 , if odd aNum then aList ++ replicate ( aList !! (aNum 
 - 1 ) ) 1 else aList ++ replicate ( aList !! ( aNum - 1 ) ) 2 )

main :: IO ( )
main = do
   putStrLn "Enter a number greater than 3!" 
   numberline <- getLine
   let num = ( read numberline :: Int )
   print $ length $ findIndices ( == 1 ) $ take num $ kolakoski num 
