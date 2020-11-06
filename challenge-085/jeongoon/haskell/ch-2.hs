import System.Environment
import System.Exit
import Data.Ratio (denominator)
import Data.Maybe (catMaybes)

{- tested with:
runhaskell ch-2.hs 144
1 as 12^2 = 144
runhaskell ch-2.hs 107
0
-}

maxFactor :: (Integral c, Integral a) => a -> c
maxFactor n = (floor . sqrt . fromIntegral) n

findPowerOfTwoIntegers :: Integer -> Maybe (Integer, Integer)
findPowerOfTwoIntegers n =
  case (take 1 abPairs) of
    [] -> Nothing
    [(f, p)] -> Just (f, p)
  where abPairs = catMaybes [ if d == 1 then Just (f, (floor pow))
                                  else Nothing
                                | f <- [maxFac,(maxFac-1)..2],
                                  let pow = logn'/(log' f)
                                      d   = (denominator . toRational) pow ]

        maxFac = maxFactor n
        logn'  = log' n
        log'  :: (Floating a, Integral c) => c -> a
        log' = (log . fromIntegral)

main = do
  args <- getArgs;
  if length args /= 1
    then die "Usage: runhaskell ch-2.hs <an integer>"
    else
    let istr = args !! 0
        i    = read istr :: Integer
        ans  = findPowerOfTwoIntegers i
    in case ans of
      Nothing     -> putStrLn "0"
      Just (a, b) -> putStrLn $
                     "1 as " ++ (show a) ++ "^" ++ (show b)
                     ++ " = " ++ istr
