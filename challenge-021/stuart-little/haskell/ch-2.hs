#!/usr/bin/env runghc

-- run <script> <URI>

import Data.Char (toLower,)
import Data.List.Split (splitOn,)
import Data.Maybe (fromJust,)
import Network.URI (normalizeCase,normalizeEscape,normalizePathSegments,unEscapeString,parseURI,uriAuthority,uriRegName,)
import System.Environment (getArgs,)

main = do
  uri <- getArgs >>= return.head
  let woAuth = unEscapeString $ normalizePathSegments $ normalizeEscape $ normalizeCase uri
      auth = uriRegName $ fromJust $ uriAuthority $ fromJust $ parseURI woAuth
      (l:r:_) = splitOn auth woAuth  
  putStrLn (l ++ (map toLower auth) ++ r)
