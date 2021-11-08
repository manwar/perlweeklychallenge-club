#!/usr/bin/env runghc

-- run <script> <number>

import Data.List (inits)
import System.Environment (getArgs)

fstRunOver :: String -> String -> [String]
fstRunOver s1 s2 = reverse $ head $ dropWhile (\xss -> (length s2) > (sum $ map length xss)) $ iterate (\xs -> (show $ (+) 1 $ (read::String->Int) $ head xs):xs) [s1]

consecSplit :: String -> [String]
consecSplit s = head $ dropWhile (\ss -> s /= concat ss) $ map (\s'-> fstRunOver s' s) $ tail $ inits s

main :: IO ()
main = getArgs >>= putStrLn . unwords . consecSplit . head
