#!/usr/bin/env runghc

-- run <script> <file-path>

import System.Directory (getFileSize,)
import System.Environment (getArgs,)
import System.IO (IOMode( ReadMode ),openFile,)
import qualified Data.ByteString as B
import qualified Data.ByteString.UTF8 as B

main = do
  pth <- getArgs >>= return . head
  fs <- getFileSize pth
  hand <- openFile pth ReadMode
  cont <- B.hGetContents hand
  let tp = if elem B.replacement_char $ B.toString cont
           then "binary"
           else "text"
  putStrLn $ if fs==0 then "empty file"
             else tp ++ " file"
    
