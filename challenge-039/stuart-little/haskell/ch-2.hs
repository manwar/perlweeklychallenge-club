#!/usr/bin/env runghc

-- run <script> <RPN expression with space-separated tokens>

import Data.Maybe (isJust,fromJust,)
import System.Environment (getArgs,)
import Test.Tasty.Options (safeRead,)

rpnEval :: [Float] -> [(String,Float->Float->Float)] -> [String] -> [Float]
rpnEval stack dict input
  |null input =stack
  |isJust nxt =rpnEval ((fromJust nxt):stack) dict (tail input)
  |isJust op =rpnEval (((fromJust op) s f):rest) dict (tail input)
  |otherwise =error "parsing error" where
     nxt = safeRead (head input)::Maybe Float
     op = lookup (head input) dict
     (f:s:rest) = stack

main = do
  input <- getArgs
  let dict = [ ("+",(+))
             , ("-",(-))
             , ("*",(*))
             , ("/",(/))]
  print $ rpnEval [] dict input
