#!/usr/bin/env runghc

-- run <script> <expression: two roman numerals separated by a space-surrounded operator>

import Data.Char (toUpper,)
import Data.Either (fromRight,)
import Data.Maybe (fromJust,)
import Language.Haskell.Interpreter
import System.Environment (getArgs,)
import Text.Numeral.Roman (fromRoman,toRoman,)

main :: IO ()
main = do
  (lrom:op:rrom:_) <- getArgs >>= return.((map.map) toUpper)
  let (lint:rint:_) = map (\rom -> show $ fromJust $ fromRoman rom) [lrom,rrom] 
  x <- (runInterpreter $ setImports ["Prelude"] >> eval (unwords [lint,op,rint]))
  putStrLn $ toRoman $ (read::String->Float) $ fromRight "" x
