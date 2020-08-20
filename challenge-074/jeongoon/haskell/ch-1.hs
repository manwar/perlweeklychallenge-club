{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
import Options.Generic
import JRandomList
import Data.List ( sort, unfoldr )

import Data.Maybe
import System.Random ( randoms, randomR, randomRs, newStdGen, StdGen )

{- Tested with:
runhaskell -i. ch-1.hs 10
-}

-- Solution
getMajor []   = (-1)
getMajor [x]  =  x
getMajor list = case (last.processMajor.sort) list of
                  Nothing  -> (-1)
                  Just (x) ->   x
  where
    majlen = (length list) `div` 2
    processMajor list@(l:ls) = unfoldr recordMajor ( ( l, 1), ls )
    recordMajor ( (x, cnt), ls )
      | null ls    = Nothing                                 -- edge case
      | x == y     = if cnt == majlen
                    then Just( Just x, ( (x ,succ cnt), [] ) ) -- major found
                    else Just ( Nothing, ((x, succ cnt), ys) )
      | otherwise = Just ( Nothing, ( (y, 1), ys ) )
        where y = head ls; ys = tail ls;

{- Comment: probably I could use `(filter f).group.sort' approach
            but I still want to study more about haskell. -}

-- Testing
aSample size seed =
  let majEnsured = head ( randoms seed :: [Bool] )
      halfSize   = size `div` 2
      lo = 0
      hi = size -1
      ( majNum, seed' ) = randomR ( lo, hi ) seed
      majCnt  = fst $ if majEnsured then randomR ( halfSize+1, size-1 ) seed'
                      else randomR ( 0, halfSize ) seed'
      majList = replicate majCnt majNum
      rstList = take (size - majCnt) (randomRs (lo, hi) seed)
      majInfo = if majEnsured then Just ( majNum, majCnt ) else Nothing
  in
    ( majInfo, shuffleByPickingAll ( majList ++ rstList ) seed )

validateSizeIO :: (Ord a, Show a) => a -> a -> IO a
validateSizeIO def given = do
  if given < def then
    putStrLn ( "Given size is too short: " ++ (show given)
               ++ ": using default size: " ++ (show def) )
    >> return def
    else putStrLn( "Given Size:" ++ (show given) )
    >> return given

main = do
  args <- getRecord "Challenge #074 - Task #1"
  let defS = 2
      sStr = show ( args :: Int )
      s = read sStr :: Int
      getSize = validateSizeIO defS s in
    do
      size <- getSize;
      seed <- newStdGen;
      let ex = aSample size seed
          majorInfoExist = isJust( fst ex )
          majorNum   = (fst.fromJust) (fst ex)
          solution = getMajor (snd ex)
        in do
        -- XXX: even though I didn't intend to make majority number
        --      random list still could contain a majority number
        putStr $ "Input: " ++
          (if majorInfoExist then "Major = " ++ show majorNum
           else "*Maybe* No Major" ) ++ ": "
        print $ snd ex
        putStr   "Output: "
        print $ solution
