{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
import Options.Generic
import JCombinations (combinationsIndex)
import Data.List (unfoldr)
import System.Exit (die)

-- solution
getLargestRectArea :: [Int] -> Int
getLargestRectArea hdata = maximum allPossibleAreas where
  allPossibleAreas =  map calcArea1 [ 0 .. (dataLen - 1) ]
                      ++ map calcArea2 (combinationsIndex 2 dataLen)
    where
      dataLen   = length hdata
      calcArea1 = (hdata !!)
      calcArea2 = (\xs -> (commonH xs) * ((last xs)-(head xs)+1))
      commonH xs = (minimum.map (hdata !!)) [ (head xs) .. (last xs) ]

-- bonus
printHistogram :: [Int] -> IO ()
printHistogram hdata = do
  mapM_ putStrLn lineBuffers where
    hdataLen    = length hdata
    maxH        = maximum hdata
    lineBuffers = unfoldr forYaxis maxH
    forYaxis (y)
      | y ==  0   = Just( replicate (wordWidth * (hdataLen +1)) '_',  y-1 )
      | y == -1   = Just( whiteSpace
                         ++ (foldl (\acc x ->
                                   acc ++ (fixedNumber x)) "" hdata) , y-1 )
      | y < -1   = Nothing
      | otherwise = Just( yScale ++ allColumnData, y-1 )
      where
        wordWidth  = ((length.show) maxH) +1
        whiteSpace = replicate wordWidth ' '
        yScale     = fixedNumber y
        fixedNumber   n = (preWhiteSpace n) ++ (show n)
        sharpMark       = (replicate (wordWidth - 1) ' ') ++ ['#']
        preWhiteSpace n = replicate (wordWidth - (length (show n))) ' '
        allColumnData   =
          foldl (\acc x -> acc ++ (if x < y
                               then whiteSpace else sharpMark )) "" hdata

-- testing
main = do
  args <- getRecord "Challenge #075 - Task #2"
  let sample = args::[Int] in do
    if null sample then die "list not given: runhaskell ch-2.hs <list ...>"
      else return ()
    putStrLn ("Input: "  ++ (show sample))
    putStrLn ("Output: " ++ (show (getLargestRectArea sample)))
    printHistogram sample
