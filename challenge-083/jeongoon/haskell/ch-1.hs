import System.Environment
import System.Exit

{- test with:
runhaskell ch-1.hs "Perl W e e k l y Challenge" # output: 6
-}
main = do
  args <- getArgs;
  if length args /= 1
    then die "Usage: runhaskell ch-1.hs <a string with 3 or more words"
    else let ws = words (args !! 0)
             wl = length ws
         in
           if wl < 3 then die "we need 3 words at least"
           else (putStrLn.
                 show.
                 length.
                 foldr1 (++).
                 take (wl-2).
                 drop 1) ws
