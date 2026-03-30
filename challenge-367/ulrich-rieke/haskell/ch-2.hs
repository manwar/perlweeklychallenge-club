module Challenge367_2
   where
import Data.List.Split( splitOn )

--determines if the second time term is later than the first one
isLater :: String -> String -> Bool
isLater first second =
   let [firstHours , firstMinutes] = splitOn ":" first
       [secondHours , secondMinutes] = splitOn ":" second
   in if firstHours /= secondHours then secondHours > firstHours 
    else secondMinutes > firstMinutes

solution :: String -> String -> Bool
solution firstEvent secondEvent = 
   let [firstStart , firstEnd] = words firstEvent
       [secondStart , secondEnd] = words secondEvent
   in if firstStart == secondStart then True else not ( isLater 
    firstEnd  secondStart || firstEnd == secondStart )

main :: IO ( )
main = do
   putStrLn "Enter start and end times of a first event!"
   firstEvent <- getLine
   putStrLn "Enter start and end times of a second event!"
   secondEvent <- getLine
   print $ solution firstEvent secondEvent
