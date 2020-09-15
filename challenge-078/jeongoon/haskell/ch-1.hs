import System.Environment
import Data.List (mapAccumR)
import Data.Char (isNumber)
import Data.Maybe (catMaybes)

-- tested with: runhaskell ch-1.hs 9 10 7 5 6 1

leaderElement [] = [0] -- challenge spec.
leaderElement ls = (catMaybes.snd) $ mapAccumR revLeader (minimum ls) ls where
  revLeader curLeader newElement
    | curLeader <= newElement = (newElement, Just newElement)
    | otherwise = (curLeader, Nothing)

main = do
  (print.leaderElement.catMaybes)
    =<< map (\nStr -> if (all isNumber nStr) then Just(read nStr :: Int)
                     else Nothing ) `fmap` getArgs
