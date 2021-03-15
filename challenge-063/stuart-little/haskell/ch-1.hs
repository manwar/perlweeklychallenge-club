#!/usr/bin/env runghc

{-
run <script> <quoted_string quoted_regex (no slashes)>

very basic: doesn't know about case-insensitivity
-}

import System.Environment (getArgs,)
import Text.Regex.PCRE ((=~),)
import Data.List.Extra (lastDef,)

last_word :: String -> String -> String
last_word str rx = lastDef "NO MATCH" $ filter (\w -> w =~ rx::Bool) $ words str

main = do
  (str:rx:_) <- getArgs
  putStrLn $ last_word str rx
