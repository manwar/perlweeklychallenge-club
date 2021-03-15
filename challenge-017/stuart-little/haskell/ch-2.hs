#!/usr/bin/env runghc

-- run <script> <uri>

import Control.Monad (liftM,)
import Data.Maybe (fromJust,fromMaybe,)
import Network.URI (parseURI,nullURI,uriScheme,uriPath,uriQuery,uriFragment,uriAuthority,uriUserInfo,uriRegName,uriPort,)
import System.Environment (getArgs,)

main = do
  uri <- getArgs >>= return.head >>= return.(fromMaybe nullURI).parseURI
  let nonAuth = zip ["scheme","path","query","fragment"] $ [uriScheme,uriPath,uriQuery,uriFragment] <*> [uri]
  let auth = zip ["user","host","port"] $ (map (\f -> (fromMaybe "").(liftM f).uriAuthority) [uriUserInfo,uriRegName,uriPort]) <*> [uri]
  mapM_ putStrLn $ map (\(l,r)-> l ++ ": " ++ r) $ nonAuth ++ auth
