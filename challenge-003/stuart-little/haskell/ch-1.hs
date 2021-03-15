#!/usr/bin/env runghc

-- run <script> <nr_lines>

import System.Environment (getArgs,)
import Combinatorics (binomials,)

main = do
  (nrlines:_) <- getArgs
  mapM_ print $ take (read nrlines::Int) $ binomials   
