#!/usr/bin/env runghc

-- run <script> <quoted string>

import System.Environment (getArgs,)

main = do
  ln <- getArgs >>= return.head >>= return.sum.(map length).init.tail.words
  print ln
