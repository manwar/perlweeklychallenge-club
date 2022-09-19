module Challenge172_2
  where
import Data.List( sort , (!!) )
import Data.List.Split ( splitOn )

findMedian :: [Double] -> Double
findMedian list
  |even len = ((sorted !! ( div len 2 - 1 )) + ( sorted !! ( div len 2 ) )) / 2
  |odd len = sorted !! ( div len 2 )
  where
    len = length list
    sorted = sort list

firstQuartile :: [Double] -> Double
firstQuartile list
  |even len = findMedian $ take ( div len 2 ) sorted
  |otherwise = findMedian $ take ( div len 2 + 1 ) sorted
  where
    len = length list
    sorted = sort list

thirdQuartile :: [Double] -> Double
thirdQuartile list
  |even len = findMedian $ drop ( div len 2 ) sorted
  |otherwise = findMedian $ drop ( div len 2 ) sorted
  where
    len = length list
    sorted = sort list

askForInput :: IO [Double]
askForInput = do
  putStrLn "Enter at least 5 numbers separated by blanks!" ;
  nums <- getLine ;
  let numbers = map read $ splitOn " " nums
  if length numbers >= 5
  then return numbers
  else do
      askForInput

main :: IO ( )
main = do
  numbers <- askForInput
  let sorted = sort numbers
  putStrLn ("Minimum : " ++ ( show $ minimum sorted ))
  putStrLn ("Median : " ++ ( show $ findMedian sorted ))
  putStrLn ("First Quartile : " ++ ( show $ firstQuartile sorted ))
  putStrLn ("Third Quartile : " ++ ( show $ thirdQuartile sorted ))
  putStrLn ("Maximum : " ++ ( show $ maximum sorted ))
