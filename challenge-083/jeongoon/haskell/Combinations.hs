{- Copyright (c) 2020 JEON Myoungjin <jeongoon@g... > -}

module Combinations
  ( combinations
  ) where

combinations :: [a] -> Int -> [[a]]
combinations []     _  = []
combinations (m:ms) 1 = [m] : (combinations ms 1)
combinations [_]    2 = []
combinations [e,f]  2 = sequence [ [e],[f] ]
combinations (m:ms) 2 = sequence [ [m],  ms ] ++ (combinations ms 2)
combinations mls    n =
  case totalLen `compare` n of
    LT -> []
    EQ -> [mls]
    _  -> [ let leaders = map (mls!!) ids
            in  leaders ++ followers |
            ids <- combinations [ 0 .. room ] n',
            let skipCount = (last ids) + 1,
                followers <- (combinations (drop skipCount mls) 2) ]
  where
    totalLen    = length mls
    room        = totalLen - 2
    n'          = n - 2
