#!/usr/bin/env runghc

-- run <script> <space-separated treasure spots, encoded as letter-digit>
-- e.g. <script> a2 b1 b2 b3 c4 e6

import Data.Char (toLower)
import Safe (elemIndexJust)
import System.Environment (getArgs)

tour :: [String]
tour = ["a8", "c7", "e6", "g5", "h3", "g1", "e2", "c1", "a2", "b4", "d3", "f2", "h1", "g3", "f1", "d2", "b1", "a3", "c2", "e1", "f3", "h2", "g4", "e3", "g2", "f4", "d5", "c3", "d1", "b2", "a4", "b6", "c4", "e5", "d7", "f8", "h7", "f6", "h5", "g7", "e8", "d6", "e4", "c5", "a6", "b8", "c6", "d4", "b5", "a7", "c8", "e7", "g8", "h6", "f5", "h4", "g6", "h8", "f7", "d8", "b7", "a5", "b3", "a1"]

untilFoundAll :: Eq a => [a] -> [a] -> [a]
untilFoundAll xs ys = take (nr+1) ys where
  nr = maximum $ map (\x-> elemIndexJust x ys) xs

decorate :: String -> [String] -> [String] -> [String]
decorate s xs ys = map (\y -> if (elem y xs) then y ++ s else y) ys

main :: IO ()
main = do
  treasure <- getArgs >>= return . (\x-> if (null x) then ["a2", "b1", "b2", "b3", "c4", "e6"] else map (map toLower) x)
  putStrLn $ unlines $ decorate " TREASURE" treasure $ untilFoundAll treasure tour
