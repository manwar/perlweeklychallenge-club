#!/usr/bin/env runghc

{--
run <script> <module name, e.g. Data.List>
the module must be in your search path
defaults to Data.List if you pass no arguments
--}

{-# LANGUAGE OverloadedStrings #-}
import Safe (headDef)
import Shelly
import System.Environment (getArgs)
import qualified Data.Text as T

mdl :: IO String
mdl = getArgs >>= return . headDef "Data.List"

runShelly :: String -> IO ()
runShelly mdl = shelly $ silently $ do  
    out <- run "ghc" ["-e", T.pack (":browse " ++ mdl)]
    let lns = T.lines out
    liftIO $ mapM_ (putStrLn .T.unpack) $ lns

main :: IO ()
main = mdl >>= runShelly
