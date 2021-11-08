#!/usr/bin/env runghc

-- run <script> <space-separated numbers>

import System.Environment (getArgs)

runAvg :: (Fractional a, Num a, Enum a) => [a] -> [a]
runAvg xs = zipWith (/) (scanl1 (+) xs) [1..]

main :: IO ()
main = getArgs >>= putStrLn . unwords . map show . runAvg . map (read::String->Double)
