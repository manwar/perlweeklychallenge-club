module Challenge351
   where
import Data.List ( findIndex )
import Data.Maybe ( fromJust )

solution :: [Int] -> Double
solution list = 
   let maxi = maximum list
       mini = minimum list
       maxpos = fromJust $ findIndex ( == maxi ) list
       withoutOne = take maxpos list ++ drop ( maxpos + 1 ) list
       minpos = fromJust $ findIndex ( == mini ) withoutOne
       withoutTwo = take minpos withoutOne ++ drop ( minpos + 1 ) withoutOne
  in (fromIntegral $ sum withoutTwo) / ( fromIntegral $ length withoutTwo )

main :: IO ( )
main = do
   putStrLn "Enter some numbers separated by blanks!"
   numberline <- getLine
   let numbers = map read $ words numberline
   if all ( == head numbers ) numbers then print 0 else print $ solution numbers 
