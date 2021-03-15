#!/usr/bin/env runghc

-- run <script>

import System.Environment (getArgs,)
import Data.Time.Calendar (dayOfWeek,fromGregorian,DayOfWeek( Sunday ),)

main = do
  mapM_ print $ filter (\d -> Sunday == (dayOfWeek d)) $ map (\y -> fromGregorian y 12 25) [2019..2100]
