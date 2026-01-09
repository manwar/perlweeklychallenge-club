module Challenge355_2
   where
import Data.List.Split ( divvy )
import Data.List ( findIndices , (!!) )

solution :: [Int] -> Bool
solution list = 
   let maxnum = maximum list
       maxindex = head $ findIndices ( == maxnum ) list
       rising = map (\p -> last p - head p ) $ divvy 2 1 $ take
        ( maxindex + 1 ) list
       falling = map (\p -> last p - head p ) $ divvy 2 1 $ drop maxindex
        list
   in and [length list > 2 , maxindex /= 0 , maxindex /= (length list - 1) , 
    all( > 0 ) rising , all ( < 0 ) falling]

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!"
   numberline <- getLine
   print $ solution $ map read $ words numberline

