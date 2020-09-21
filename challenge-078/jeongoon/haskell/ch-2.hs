import System.Environment
import Data.List (mapAccumL)
import Data.Char (isNumber)
import Data.Maybe (catMaybes)

-- tested with: runhaskell ch-2.hs 7 4 2 6 3 / 1 3 4
-- use any non-digit value as a separator between @A and @B

unsafe_mapLeftRotate ls = map (\r -> (drop r ls) ++ (take r ls) )
parseNumbers = catMaybes.map (\nStr -> if (all isNumber nStr)
                                        then Just(read nStr:: Int) else Nothing)
main = do (mapM_ print.
           uncurry unsafe_mapLeftRotate.(\(a,b) -> (a, parseNumbers b)))
           =<< (span (all isNumber)) `fmap` getArgs
