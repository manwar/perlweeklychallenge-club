module Challenge179_2
  where
import Data.List.Split ( divvy , splitOn )
import Data.List ( findIndex , ( !! ) )
import Data.Maybe ( fromJust )

--find the eigth quantiles in a number of given doubles
findOctals :: [Double] -> [Double]
findOctals numbers = [min] ++ intermediates ++ [max]
  where
  min :: Double
  min = minimum numbers
  max :: Double
  max = maximum numbers
  intermediates :: [Double]
  intermediates = map (\d -> (max - min) / 8.0 * ( fromIntegral d ) )
    [1 .. 7]

--which 'octile' does a given number belong to ?
--every interval bar the last one is closed at the left end and open at the
--right, the last interval is open at the left end and includes the maximum
findInterval :: Double -> [Double] -> Int
findInterval number octalLimits =  if ( (number > (octalLimits !! 6))  && (
number <= ( last octalLimits ))) then 7 else fromJust ( findIndex
(\li -> (number >=  head li) && (number < last li ))  startList)
  where
  startList :: [[Double]]
  startList = init $ divvy 2 1 octalLimits

--these are the unicode strings that denote black bars of increasing height
bars :: [String]
bars = ["\9601" , "\9602" , "\9603" , "\9604" , "\9605" ,
    "\9606" , "\9607" , "\9608"]

--enter some double and convert them to a series of unicode strings, all
--glued together
solution :: [Double] -> String
solution numbers = foldl1 ( ++ ) $ map(\i -> bars !! i ) $ map
(\d -> findInterval d octalLimits ) numbers
  where
  octalLimits :: [Double]
  octalLimits = findOctals numbers

main :: IO ( )
main = do
  putStrLn "Enter a some numbers , separated by a blank!"
  numbers <- getLine
  let nums = map read $ splitOn " " numbers
  putStrLn $ solution nums
