module Challenge128_2
  where
import Data.List ( (!!) )
import Data.List.Split ( splitOn )

toMinutes :: String -> Int
toMinutes time = (60 * (list !! 0 )) + ( list !! 1 )
where
  list :: [ Int ]
  list = map read $ splitOn ":" time

findTrainsInStation :: [String] -> [String] -> [Int]
findTrainsInStation arrivals departures = map (\i -> length $ filter ( >
( toMinutes $ arrivals !! i )) $ take i departuretimes ) [1..l - 1]
where
  l :: Int
  l = length arrivals
  departuretimes :: [ Int ]
  departuretimes = map toMinutes departures

solution :: [String] -> [String] -> Int
solution arrivals departures = ( maximum $ findTrainsInStation arrivals
departures ) + 1
