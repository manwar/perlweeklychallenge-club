{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
import Options.Generic
import JRandomList
import System.Random ( StdGen, newStdGen )
import Data.Maybe
import Data.List( unfoldr )

{- Tested with:
runhaskell -i. ch-2.hs 3
-}

aSample :: (Integral a, Num a, Enum a) =>
              a -> StdGen -> [Int]
-- skip small number an making an example: otherwise result is too boring
aSample size seed =
  let s' = fromIntegral size in
  shuffleByPickingAll [ s' .. (pred (2*s') {-index-}) ] seed

validateSizeIO :: (Ord a, Show a) => a -> a -> IO a
validateSizeIO def given = do
  if given < def then
    putStrLn ( "Given size is too short: " ++ (show given)
               ++ ": using default size: " ++ (show def) )
    >> return def
    else putStrLn( "Given Size:" ++ (show given) )
    >> return given

generateSmallest :: ( Integral a, Ord a )
  => ( Maybe a, [a] ) ->  Maybe ( a, ( Maybe a, [a] ) )
generateSmallest ( _,  [] ) = Nothing
generateSmallest ( Nothing, ls@(c:ls') ) = Just( 0, ( Just c, ls' ))
generateSmallest ( Just s,  ls@(c:ls') ) =
  if c <= s then Just( 0, ( Just c, ls' )) -- couldn't find smallest on the left
  else Just( s, ( Just s, ls' ))

processSmallest = curry (unfoldr generateSmallest) Nothing

main :: IO ()
main = do
  args <- getRecord "Challenge #073 - Task #2"
  let defS = 3
      sStr = show ( args :: Int )
      s = read sStr :: Int
      getSize = validateSizeIO defS s in
    do
      size <- getSize;
      seed <- newStdGen;
      let ex = aSample size seed in do
        putStr "Input: "
        print $ ex
        putStr "Output: "
        print $ processSmallest ex
