#!/usr/bin/env runghc

-- run <script>

import System.Environment (getProgName,)

main = do
  filename <- getProgName
  contents <- readFile filename
  putStrLn contents
