#!/usr/bin/env runghc

-- run <script> <starting arrivals followed by departures, all space-separated>

import Data.List (sortOn)
import System.Environment (getArgs)

pfrms :: [String] -> Int
pfrms xs = maximum $ map sum $ scanl (\station time -> (take (snd time) station) ++ ([mod (1 + (station !! (snd time))) 2]) ++ (drop (1 + (snd time)) station)) (replicate (div (length xs) 2) 0) $ sortOn fst $ map (\(x,y)-> (x, mod y (div (length xs) 2))) $ zip xs [0..]

main :: IO ()
main = getArgs >>= putStrLn.show.pfrms
