import System.Environment
import System.Exit
import Data.Char (isNumber)
import Data.Maybe (isJust, catMaybes)
import Data.List (sum)
import Combinations (combinations)


{- test with:
   runhaskell ch-2.hs 12 7 4 # answer: 12
   runhaskell ch-2.hs 12 7 4 5 6 9 20 12 7 4 5 6 9 20 9 4 2 1 13 8 # answer: 6
 # or in order to get faster result, you can compile and execute:
   ghc ch-2.hs
   ./ch-2 12 7 4 5 6 9 20 12 7 4 5 6 9 20 9 4 2 1 13 8 # answer: 6
-}

answerFlipArray :: (Integral a) => [a] -> Int
answerFlipArray nums
  | totalSum == 1 = 0
  | otherwise = answerWith totalSum totalLen numCombis
  where
    totalSum  = sum nums
    totalLen  = length nums
    halfLen   = totalLen `div` 2
    numCombis = (foldr1 (++) .
                    map (combinations nums))
                   [ 1 .. halfLen ]

    answerWith _      minElems [] = minElems
    answerWith minSum minElems (aCombi:otherCombis) =
      case (positiveSum `compare` minSum) of
        LT -> answerWith positiveSum newElems otherCombis
        EQ -> answerWith minSum (min newElems minElems) otherCombis
        GT -> answerWith minSum minElems otherCombis
      where
        len  = length aCombi
        sm   = sum aCombi
        sm'  = totalSum - sm
        (positiveSum, newElems) =
            case (sm `compare` sm') of
              LT -> ( sm' - sm, len )
              EQ -> (        0, (min len (totalLen - len)) )
              GT -> ( sm - sm', (totalLen - len) )

main = do
    (catMaybes.map (\nStr ->
                       if (all isNumber nStr) then Just(read nStr :: Int)
                       else Nothing )) `fmap` getArgs
      >>= (\nums ->
              if length nums < 1 then
                die "Usage: runhaskell ch-2.hs <natural num> ..."
              else
                putStrLn $ show ( answerFlipArray nums ) )
