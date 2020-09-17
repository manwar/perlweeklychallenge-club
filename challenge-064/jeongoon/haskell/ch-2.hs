import System.Environment
import System.Exit
import Data.List (nub, intersect, subsequences)

main = do
  args <- getArgs
  if length args < 2 then die "[WRN] 0 as No data given."
    else
    let s = head args
        ws = tail args
        res = nub $ intersect (subsequences s) ws
    in do
    putStrLn $ "[INF] $S = " ++ (show s)
    putStrLn $ "[INF] @W = " ++ (show ws)
    if (length res == 0) then putStrLn "0 as none matching word found."
      else putStrLn (show res)
