module Challenge285
   where
import Data.List.Split ( splitOn )

solution :: String -> String
solution input =
   let routes = splitOn "," input
       routepairs = map (\li -> (head li , last li ) ) $ map ( concat .
	splitOn " " ) routes
       starts = map fst routepairs
       destinations = map snd routepairs
  in filter (\dest -> notElem dest starts ) destinations 

main :: IO ( )
main = do
   putStrLn "Enter some routes, separated by ','!"
   putStrLn "Separate start and destination by a blank!" 
   allRoutes <- getLine
   print $ solution allRoutes
