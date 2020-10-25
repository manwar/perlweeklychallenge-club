{- Copyright (c) 2020 JEON Myoungjin <jeongoon@g... > -}

module Combinations
  ( combinations
  ) where

combinations :: [a] -> Int -> [[a]]
combinations []     _  = []
combinations (m:ms) 1 = [m] : (combinations ms 1)
combinations [_]    2 = []
combinations [e,f]  2 = [[e,f]]
combinations (m:ms) 2 = sequence [[m], ms] ++ (combinations ms 2)
combinations mls    n =
  case totalLen `compare` n of
    LT -> []
    EQ -> [mls]
    _  -> [ let leaders = map (fst) tups
            in  leaders ++ followers |
            tups <- combinations (zip mls [0 .. room])  n',
            let skipCount = ((snd.last) tups) + 1,
                followers <- (combinations (drop skipCount mls) 2) ]
  where
    totalLen    = length mls
    room        = totalLen - 2
    n'          = n - 2
