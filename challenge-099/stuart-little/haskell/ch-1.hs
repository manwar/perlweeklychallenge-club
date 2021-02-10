#!/usr/bin/env runghc

{-
run <script> <string> <singly-quoted pattern>

- you can escape literal '?' and '*', as in '\?' and '\*'

- you can also escape literal backslashes: '\\' registers as a single literal backslash, no matter what it's followed by

any other unescaped instance of the backslash is meaningless: '\x' is just 'x'
-}

import Data.List (tails)
import Data.List.Extra (notNull)
import System.Environment (getArgs)

mtch :: String -> String -> Bool
mtch "" "" = True
mtch pat ss |(null pat || null ss) && notNull (pat ++ ss) = False
mtch ('\\':c:ps) (d:ss) = (c==d) && (mtch ps ss)
mtch ('?':ps) (d:ss) = (mtch ps ss)
mtch ('*':ps) ss = any id $ map (mtch ps) $ tails ss
mtch (c:ps) (d:ss) = (c==d) && (mtch ps ss)

main = do
  (str:pat:_) <- getArgs
  print $ fromEnum $ mtch pat str
