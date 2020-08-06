import System.Environment
import System.IO
import System.IO.Error
import System.Exit
import Data.List
import Control.Exception

{-- Tested with:
runhaskell ch-2.hs [<file name>] [A] [B]
--}

{-- Refs:
http://learnyouahaskell.com/input-and-output#files-and-streams
https://hackage.haskell.org/package/base-4.14.0.0/docs/System-Exit.html
https://stackoverflow.com/questions/21208771/exception-handling-for-readfile
https://stackoverflow.com/questions/42609508/not-in-scope-catch
--}


putLinesBetween :: Handle -> Int -> Int -> Int -> IO()
putLinesBetween fh from to acc
  | from > to =
    do
      putStrLn $ "[INF] Nothing to print: from > to"
      return ()
  | from <= 0 =
    do
      putStrLn $ "[WRN] line starts from: 1 not: " ++ show from
      putStrLn $ "[INF] -> Starts with line no. 1 again."
      putLinesBetween fh 1 to acc
  | acc >= from && acc <= to =
    do
      line <- hGetLine fh
      putStrLn line
      putLinesBetween fh from to $! (acc+1)
  | otherwise                = return ()

toTry :: IO ()
toTry = do
  args <- getArgs

  if length args /= 3 then
    die $ "[ERR] Wrong Number of Args: " ++ (show (length args)) ++ " must be  == 3"
    else
    return ()

  let filePath = args !! 0
  let from = read ( args !! 1 ) :: Int
  let to   = read ( args !! 2 ) :: Int

  putStrLn $ "[INF] FilePath: " ++ filePath
  fh <- openFile filePath ReadMode
  putLinesBetween fh from to 1
  hClose fh

handler :: IOError -> IO ()
handler e  = putStrLn $ "[ERR] Aborted: " ++ show e

main = toTry `catch` handler
