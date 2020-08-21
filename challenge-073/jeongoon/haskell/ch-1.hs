{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
import Options.Generic
import JRandomList
import System.Random ( StdGen, newStdGen )
import Data.Maybe

{- Tested with:
runhaskell -i. ch-1.hs 3
-}

aSample :: (Integral a, Num a) =>
              a -> StdGen -> [Int]
aSample winSize seed =
  -- size 3 -> frameSize: 10
  let frameSize = 10 * round(  0.3 * fromIntegral winSize )
  in shuffleByPickingAll [ 0 .. (pred frameSize {-index-}) ] seed

validateSizeIO :: (Ord a, Show a) => a -> a -> IO a
validateSizeIO def given = do
  if given < def then
    putStrLn ( "Given size is too short: " ++ (show given)
               ++ ": using default size: " ++ (show def) )
    >> return def
    else putStrLn( "Given Size:" ++ (show given) )
    >> return given

groupMinimumListSimple_ :: (Ord a) => [a] -> [a] -> Int -> [a]
groupMinimumListSimple_ acc ls s
  | length sld /= s      = acc
  | otherwise           = groupMinimumListSimple_ acc' ls' s where
      sld  = take s ls
      ls'  = tail ls
      acc' = acc ++ [ minimum sld ]

groupMinimumListSimple = groupMinimumListSimple_ []

someMinValuesWithIndics' :: ( Ord a, Enum a )
  => a -> Maybe (([a], [Int]), Int) -> Maybe (([a], [Int]), Int)
-- set default offset value if nothign specified : not used here
--minValuesWithIndics' x Nothing = minValuesWithIndics' x (Just (([x], [0]), 1))
someMinValuesWithIndics' x (Just ((min@(m:ms), idx), i))
  | x < m   = Just((x:min, i:idx), pred i)
               -- prepend the new minimum value
  | otherwise =  Just((min, idx), pred i)
                 -- keep record, change index number only

someMinValuesWithIndics ls offset =
  let i = (length ls) -1 +offset
      res = foldr someMinValuesWithIndics' (Just(([last ls], [i]), pred i)) (init ls)
  in fst( fromJust( res ) )

-- bascially same method which is described in ch-1.pl

groupMinimumList_ :: (Ord a, Enum a) =>
  ( Maybe( [a], Int, [a], [Int] ), [a] ) -> Int -> [a]

-- first step
groupMinimumList_ (Nothing, ls) s =
  let x  = head ls
      a' = 2 - s in -- 2nd number of a (when a == 0 we get full size of group)
    if 0 <= a'
    then groupMinimumList_ (Just([x], a', [x], [0]), ls) s
    else groupMinimumList_ (Just([], a', [x], [0]),  ls) s
-- edge case (no more elements)
groupMinimumList_ (Just( acc, _,   _,   _ ), []) _ = acc
groupMinimumList_ (Just( acc, a, min, mem ), ls) s =
  let b   = a + s -1   -- index for beging checked
                      -- or last index in the group when inbound
      a'  = succ a
      n   = head min;   m   = head mem
      ns  = tail min;   ms  = tail mem
      grp = take s $ drop (if a < 0 then 0 else a) ls
      x   = ls !! b
      lsize      = length ls
      memInbound = (not (null mem)) && a <= m
      grpInbound = ( 0 <= a && b < lsize ) in

    if b >= lsize then acc -- edge case
    else if (not grpInbound) || (grpInbound && memInbound) then
      let acc' q = if grpInbound then acc ++ [q] else acc
          min' = if grpInbound then [] else min
          mem' = if grpInbound then [] else mem
      in
        case ( x `compare` n ) of
          LT ->  -- new minimum
              groupMinimumList_ (Just(acc' x, a', x:min, b:mem), ls) s
          EQ ->  -- better update index only
              groupMinimumList_ (Just( (acc' n), a', min, b:ms), ls) s
          GT ->  {- just skipping : too complicate recalculate memos
                                   better compare evertying in the goup -}
              groupMinimumList_ (Just( (acc' n), a', min', mem'), ls) s

    else -- grpInbound && not memInbound
      -- memorised value at leftmost not useful anymore
      if (not (null mem) ) then -- but maybe we can use next available memo
        groupMinimumList_ (Just(acc, a, ns, ms), ls) s
      else -- compare everthing in the group
        -- meanwhile making memo as well
        let res = someMinValuesWithIndics grp a -- a: first index in the group
            min' = fst res
            mem' = snd res
            acc' = acc ++ [ head min' ] in
          groupMinimumList_ (Just(acc', a', min', mem'), ls) s

groupMinimumList :: (Ord a, Enum a) => [a] -> Int -> [a]
groupMinimumList = curry groupMinimumList_ Nothing

main :: IO ()
main = do
  args <- getRecord "Challenge #073 - Task #1"
  let defS = 3
      sStr = show ( args :: Int )
      s = read sStr :: Int
      getSize = validateSizeIO defS s in
    do
      size <- getSize;
      seed <- newStdGen;
      let ex = aSample size seed in do
        putStr "Example\nInput: "
        print $ ex
        putStr "Output 1: "
        print $ groupMinimumListSimple ex size
        putStr "Output 2: "
        print $ groupMinimumList ex size

{-
Task #1 Min Sliding Window
You are given an array of integers @A and sliding window size $S.
Write a script to create an array of min from each sliding window.

Example
Input: @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8) and $S = 3
Output: (0, 0, 0, 2, 3, 3, 4, 4)

[(1 5 0) 2 9 3 7 6 4 8] = Min (0)
[1 (5 0 2) 9 3 7 6 4 8] = Min (0)
[1 5 (0 2 9) 3 7 6 4 8] = Min (0)
[1 5 0 (2 9 3) 7 6 4 8] = Min (2)
[1 5 0 2 (9 3 7) 6 4 8] = Min (3)
[1 5 0 2 9 (3 7 6) 4 8] = Min (3)
[1 5 0 2 9 3 (7 6 4) 8] = Min (4)
[1 5 0 2 9 3 7 (6 4 8)] = Min (4)
-}
