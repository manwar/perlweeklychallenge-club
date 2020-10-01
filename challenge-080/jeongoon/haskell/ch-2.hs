import System.Environment
import System.Exit
import Data.List (zipWith)
import Data.Char (isNumber)
import Data.Maybe (isJust, catMaybes)

-- https://perlweeklychallenge.org/blog/perl-weekly-challenge-080/#TASK2
{- tested with:
runhaskell ch-2.hs 1 4 3 2
-}

countCandies []    = 0
countCandies ranks = defaultCandies + extraCandies
  where
    leftGroup = init ranks
    rightGroup = tail ranks
    defaultCandies = length ranks
    extraCandies =
      sum $ zipWith (\l r -> if l /= r then 1 else 0) leftGroup rightGroup

main = do
  nums <- (catMaybes.map (\nStr ->
                              if (all isNumber nStr) then Just(read nStr :: Int)
                              else Nothing )) `fmap` getArgs;
  if length nums == 0 then putStrLn "runhaskell ch-1.hs <unsigned integer> ..."
    else (putStrLn.show) $ countCandies nums
