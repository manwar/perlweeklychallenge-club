import System.Environment
import System.Exit
import Data.Char (isNumber)
import Data.Maybe (catMaybes)

arrayOfProduct [] = [1] -- assume 1 as spec doesn't consider this case
arrayOfProduct ns = let total = product ns in map (total `div`) ns

main = do
  ns <- (catMaybes.map (\nStr ->
                          if (all isNumber nStr) then Just(read nStr :: Int)
                          else Nothing )) `fmap` getArgs;
  print $ arrayOfProduct ns
