module Challenge120_2
  where
import Data.List.Split( splitOn )

solution :: String -> String
solution input = show (max hoursPosition minutesPosition -
min hoursPosition minutesPosition ) ++ " degrees"
where
  times :: [String]
  times = splitOn ":" input
  hours :: Int
  hours = mod ( read $ head times ) 12
  minutes :: Int
  minutes = read $ last times
  hoursPosition :: Double
  hoursPosition = ( 360.0 / 12.0 ) * ( fromIntegral hours ) + (30.0 / 60.0)
  * ( fromIntegral minutes )
  minutesPosition :: Double
  minutesPosition = ( 360.0 / 60.0 ) * ( fromIntegral minutes )
