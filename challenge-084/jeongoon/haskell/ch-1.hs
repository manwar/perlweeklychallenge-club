import System.Environment
import System.Exit
import Data.Bits (shift)

{-
tested with:
runhaskell ch-1.hs "-12345678901"
-}


filter32Bit nstr@(n:ns) =
  let lim = limitAbs Nothing (read nstr ::Int)
      limStr = show lim
      limStrWithSign = if n == '-' then '-' : limStr else limStr
      nstrAbs = case n of
                  '+' -> ns
                  '-' -> ns
                  _   -> nstr
      filteredExplanation = ("0 as\n32bit limit is " ++ limStrWithSign ++
                             "\nBut, we've got " ++ nstr)
  in case (length nstrAbs) `compare` (length limStr) of
    LT -> nstr
    EQ -> if nstrAbs < limStr then nstr else filteredExplanation
    GT -> filteredExplanation

limitAbs :: Maybe Int -> Int -> Int
limitAbs Nothing  n = limitAbs (Just 32) n
limitAbs (Just b) n  = let lim = 1 `shift` (pred b)
                     in if n < 0 then lim else lim - 1

reverseIntStr []  = []
reverseIntStr "0" = "0" -- prevent empty string when reversing zero(es)
reverseIntStr istr@(i:is) = case i of
                              '+' ->       reverse' is -- remove (+)sign as well
                              '-' -> '-' : reverse' is
                              _   ->       reverse' istr
  where reverse' xs = (dropWhile (=='0').reverse) xs

main = do
  args <- getArgs;
  if length args /= 1
    then die "Usage: runhaskell ch-1.hs <an integer>"
    else let reverseIntStr' nstr = ("Reversed: ", reverseIntStr nstr)
             filter32Bit'   nstr = ("Filtered: ", filter32Bit nstr)
             progress = scanl (\acc f -> (f . snd) acc)
               ("Input:    ",args!!0) [reverseIntStr', filter32Bit']
         in mapM_ (putStrLn.(\c -> (fst c) ++ (snd c))) progress
