module Challenge100
  where

timeConvert :: String -> String
timeConvert t
  |elem 'm' t = if elem 'p' t then (show ( hours + 12 ) ++ ":" ++
    ( show minutes ) ) else (show hours) ++ ":" ++ show minutes
  |otherwise = if ( hours > 12 ) then ( "0" ++ show ( hours - 12 ) ++ ":" ++
    (show minutes ) ++ " pm" ) else (( show hours ) ++ ":" ++ ( show minutes )
    ++ " am")
  where
      hours :: Int
      hours = read $ take 2 t
      minutes :: Int
      minutes = read $ take 2 $ drop 3 t
