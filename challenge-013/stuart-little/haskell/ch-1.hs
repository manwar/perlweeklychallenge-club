#!/usr/bin/env runghc

-- run <script> <year>

import System.Environment (getArgs,)
import Control.Monad (liftM,)
import Data.Time.Calendar (DayOfWeek( Friday ),fromGregorian,dayOfWeek,)

main = do
  (yr:_) <- liftM (map (read::String->Integer)) getArgs
  mapM_ print $ map (\m -> last $ filter ((Friday==).dayOfWeek) $ map (fromGregorian yr m) [1..31]) [1..12]
