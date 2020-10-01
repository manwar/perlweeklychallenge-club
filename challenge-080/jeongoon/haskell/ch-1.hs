import System.Environment
import System.Exit
import Data.Char (isNumber)
import Data.Maybe (isJust, catMaybes)
import qualified Data.Set as Set

-- https://perlweeklychallenge.org/blog/perl-weekly-challenge-080/#TASK1
{- tested with:
runhaskell ch-1.hs 5 -2 2 0
-}

smallestPostiveNumber ints = -- result "1" with empty list
  (head.dropWhile (isJust.((flip Set.lookupIndex) (Set.fromList ints)))) [1..]

main = do
  nums <- (catMaybes.map (\nStr ->
                              if (all isNumber nStr) then Just(read nStr :: Int)
                              else Nothing )) `fmap` getArgs;
  if length nums == 0 then putStrLn "runhaskell ch-1.hs <integer> ..."
    else (putStrLn.show) $ smallestPostiveNumber nums
