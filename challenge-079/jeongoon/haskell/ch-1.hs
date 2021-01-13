import System.Environment
import System.Exit
import Data.Bits (shift, shiftR, bit, clearBit)
import Data.Char (isNumber)
import Data.Maybe (isJust, catMaybes)

-- tested with: runhaskell ch-2.hs 99999

-- translated from ch-1.pl
-- I believed that this is not best solution but working fast enough.

trunc = (`rem` 1000000007)

countSetBits n
  | n <= 2 = n
  | n' == 0 = sumUptoPow2
  | True = sumUptoPow2 + n' + (countSetBits n')
  where
    sumUptoPow2 = ((pow * (1 `shift` pow)) `shiftR` 1) + 1
    n' = n `clearBit` pow -- === ( n - 2^pow )
    pow = (last.takeWhile ((n>=).bit)) [0..]

main = do
    (catMaybes.map (\nStr ->
                       if (all isNumber nStr) then Just(read nStr :: Int)
                       else Nothing )) `fmap` getArgs
      >>=  (\nums ->
              if length nums < 1 then die( "one positive integer, please" )
              else (putStrLn.show.trunc.countSetBits.head) nums )
