{-# LANGUAGE DeriveFunctor #-}

module Main where

import Data.Char (ord)
import Plot
import System.Exit (exitFailure)
import System.IO (hPutStrLn, stderr)

main :: IO ()
main = do
  inputLines <- lines <$> getContents
  either
    (\err -> putErrLn (show err) >> exitFailure)
    (putStr . toXML)
    (parsePlot inputLines)

putErrLn :: String -> IO ()
putErrLn = hPutStrLn stderr