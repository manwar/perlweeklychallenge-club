import Data.List (transpose, unlines)

data Schedule = Schedule
  { start :: Int,
    step :: Int,
    duration :: Int
  }
  deriving (Show)

data TimeInfo = TimeInfo
  { arrive :: Int,
    depart :: Int
  }
  deriving (Show)

timeToArriveDepart :: Schedule -> Int -> TimeInfo
timeToArriveDepart ti t =
  let factor = 1 + div (t - (start ti) - 1) (step ti)
      depart = (start ti) + factor * (step ti)
   in TimeInfo {depart = depart, arrive = depart + (duration ti)}

getArriveDepartMinutes :: Schedule -> [TimeInfo]
getArriveDepartMinutes t = map (timeToArriveDepart t) [0 ..]

checkSkipOne :: [TimeInfo] -> Bool
checkSkipOne tis =
  let next_depart = minimum $ map (depart) tis
      min_by_depart = minimum $ map (arrive) $ filter (\t -> (depart t) == next_depart) tis
      min_by_arrive = minimum $ map (arrive) tis
   in min_by_arrive < min_by_depart

skipBuses :: [Schedule] -> [Int]
skipBuses tis =
  let minute_infos = map (getArriveDepartMinutes) tis
      skip_bools = take 60 $ map (checkSkipOne) $ transpose minute_infos
      indexed_bools = zip skip_bools [0 ..]
   in map (snd) $ filter (fst) indexed_bools

results =
  map
    skipBuses
    [ [ Schedule {step = 12, start = 11, duration = 41},
        Schedule {step = 15, start = 5, duration = 35}
      ],
      [ Schedule {step = 12, start = 3, duration = 41},
        Schedule {step = 15, start = 9, duration = 35},
        Schedule {step = 30, start = 5, duration = 25}
      ]
    ]

main = putStr $ unlines $ map show results
