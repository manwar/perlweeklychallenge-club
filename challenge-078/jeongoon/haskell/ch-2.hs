import System.Environment
import Data.List
import Data.Char (isNumber)
import Data.Maybe (catMaybes)

-- tested with: runhaskell ch-2.hs 7 4 2 6 3 / 1 3 4
-- use any non-digit value as a separator between @A and @B

unsafe_mapLeftRotate ls rotates =
  scanl (\ls' n -> (drop n ls') ++ (take n ls')) ls rotates

parseNumbers = catMaybes.map (\nStr -> if (all isNumber nStr)
                                        then Just(read nStr:: Int) else Nothing)
main = do (mapM_ print.tail.
           uncurry unsafe_mapLeftRotate.(\(a,b) -> (a, parseNumbers b)))
           =<< (span (all isNumber)) `fmap` getArgs
