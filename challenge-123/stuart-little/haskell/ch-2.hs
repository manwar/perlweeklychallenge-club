#!/usr/bin/env runghc

-- run <script> <x1 y1 x2 y2 ..>

import Data.List (sort)
import Data.List.Split (chunksOf)
import System.Environment (getArgs)
import Test.LeanCheck.Stats (counts)

sqDist :: Num a => a -> a -> a -> a -> a
sqDist x1 y1 x2 y2 = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1)

sqDistHash :: (Eq a,Num a) => [a] -> [(a,Int)]
sqDistHash xs = let pts = chunksOf 2 xs in counts $ [sqDist x1 y1 x2 y2 | [[x1,y1],[x2,y2]] <- sequence [pts,pts] ]

isSq :: (Eq a,Num a) => [a] -> Bool
isSq xs = (sort $ map snd $ sqDistHash xs) == [4,4,8]

main :: IO ()
main = getArgs >>= putStrLn . show . fromEnum . isSq . map (read::String->Double).(take 8)
