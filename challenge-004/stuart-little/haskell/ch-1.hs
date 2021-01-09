#!/usr/bin/env runghc

-- run <script> in the directory where it resides

{-# LANGUAGE DataKinds #-}

import System.IO (IOMode( ReadMode ), withFile, hFileSize,)
import System.Environment (getProgName,)
import Numeric.Rounded (RoundingMode( TowardZero ), Rounded,)

main = do
  progName <- getProgName
  filesize <- withFile progName ReadMode hFileSize
  putStrLn $ "File size: " ++ show filesize
  putStrLn $ take ((fromInteger filesize) + 1) $ show (pi :: Rounded TowardZero 3000)  
