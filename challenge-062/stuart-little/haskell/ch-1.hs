#!/usr/bin/env runghc

-- run <script> <optional '-u' flag> <space-separated list of file paths>

import Data.Char (toLower)
import Data.List (sortOn)
import Data.List.Extra (nubSortOn)
import Data.List.Split (splitOn)
import System.Environment (getArgs)

normEmail :: String -> (String,String)
normEmail em = (map toLower dom, base) where
  (base,dom) = (\(x:xs)-> (x,concat xs)) $ splitOn "@" em

sortEmails :: Bool -> [String] -> [String]
sortEmails flag = srt normEmail where
  srt = if (flag == True)
        then nubSortOn
        else sortOn

main = do
  args <- getArgs
  let (flag,paths) = if (head args == "-u")
                     then (True,tail args)
                     else (False,args)
  addresses <- (mapM readFile paths) >>= return . concat . (map lines)
  mapM_ putStrLn $ sortEmails flag addresses
