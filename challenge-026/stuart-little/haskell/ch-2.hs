#!/usr/bin/env runghc

-- run <script> <space-separated angles in degrees>

import System.Environment (getArgs,)
import Data.Angle
import Data.Tuple.Extra ((&&&),)

main = do
  args <- getArgs
  print $ degrees $ Radians (uncurry atan2 $ ((sum.(map sine)) &&& (sum.(map cosine))) $ map (\x -> Degrees (read x::Float)) args)
