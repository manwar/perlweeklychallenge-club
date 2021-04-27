#!/usr/bin/env runghc

{--
run <script> <path-to-file or nothing>
defaults to challenge sample if no file is entered
--}

import Control.Monad (liftM)
import Data.List (intercalate,transpose)
import Data.List.Split (splitOn)
import System.Environment (getArgs)

defData :: String
defData = "name,age,sex\nMohammad,45,m\nJoe,20,m\nJulie,35,f\nCristina,10,f"

dt :: IO String
dt = do
  args <- getArgs
  if (null args) then return defData else readFile $ head args

trnsp :: String -> String
trnsp = unlines . map (intercalate ",") . transpose . map (splitOn ",") . lines

main :: IO ()
main = (liftM trnsp) dt >>= putStrLn
