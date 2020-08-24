{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
import Options.Generic
import Data.List ( filter, find, group, sort, inits )
import Data.Maybe

{- Tested with:
runhaskell -i. ch-2.hs "xyzzyx"
-}

-- Solution
findLNR list = map curLNR $ (tail.inits) list
  where
    curLNR cs = case (lastOne cs) of Nothing  -> '#'
                                     Just (c) ->  c
    lastOne cs = find (`elem` candidates cs) (reverse cs)
    {- *first* means unclear but examples show that we have to choose
        *last* one appears only once
        so I changed the name -}
    candidates cs = ((map head).(filter onlyone).group.sort) cs
      where onlyone x = length x == 1

-- Testing
main :: IO ()
main = do
  arg <- getRecord "Challenge #074 - Task #2"
  putStrLn ( "Input: " ++ arg :: [Char] )
  putStr "Output: "
  putStrLn $ findLNR arg


{-
TASK #2 › FNR Character
Submitted by: Mohammad S Anwar

You are given a string $S.

Write a script to print the series of first non-repeating character (left -> right) for the given string. Print # if none found.
Example 1
Input: $S = ‘ababc’
Output: ‘abb#c’
Pass 1: “a”, the FNR character is ‘a’
Pass 2: “ab”, the FNR character is ‘b’
Pass 3: “aba”, the FNR character is ‘b’
Pass 4: “abab”, no FNR found, hence ‘#’
Pass 5: “ababc” the FNR character is ‘c’

Example 2
Input: $S = ‘xyzzyx’
Output: ‘xyzyx#’
Pass 1: “x”, the FNR character is “x”
Pass 2: “xy”, the FNR character is “y”
Pass 3: “xyz”, the FNR character is “z”
Pass 4: “xyzz”, the FNR character is “y”
Pass 5: “xyzzy”, the FNR character is “x”
Pass 6: “xyzzyx”, no FNR found, hence ‘#’
-}
