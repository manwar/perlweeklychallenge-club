import System.Environment
import System.Exit
import Data.Char (isNumber)
import Data.Maybe (isJust, catMaybes)

{- test with:
runhaskell ch-1.hs 12 18
-}

-- from ch-081/ch-1.hs :-]
--commonDivisors :: (Integral a) => [a] -> [a]
commonDivisors [] = []
commonDivisors xs = filter ((==0).(rem gcd')) ([1..(gcd' `div` 2)] ++ [gcd'])
  where gcd' = foldr1 (\acc x -> gcd acc x) xs

main = do
    (catMaybes.map (\nStr ->
                       if (all isNumber nStr) then Just(read nStr :: Int)
                       else Nothing )) `fmap` getArgs
      >>=  (\nums ->
              if length nums /= 2 then
                die "Usage: runhaskell ch-1.hs <natural num> <natural num>"
              else (putStrLn.show.commonDivisors.take 2) nums )
