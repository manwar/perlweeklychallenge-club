import System.Environment
import System.Exit
import Data.Char

{-- Tested with:
runhaskell ch-1.hs [--show-divided] N
--}

{-- Refs:
https://alvinalexander.com/haskell/how-to-use-command-line-arguments-in-haskell/
https://stackoverflow.com/questions/2784271/haskell-converting-int-to-string
http://learnyouahaskell.com
http://learnyouahaskell.com/modules
https://stackoverflow.com/questions/940382/what-is-the-difference-between-dot-and-dollar-sign
... and many more..
--}

factorial :: Integer -> Integer
factorial x = product [ 1.. x ]

nthRootOfFive :: Integer -> Integer
nthRootOfFive x
  | x `mod` 5 /= 0  = 0
  | otherwise       = 1 + nthRootOfFive ( x `div` 5 )


getN :: [String] -> Integer
getN []     = 0
getN (x:xs) = if all isNumber x then read x :: Integer else getN xs

printGenTrim :: [String] -> Integer -> Integer -> IO ()
printGenTrim x n a
  | ( "--show-divided" `elem` x ) = do
      putStrLn $ "N! = " ++ fnstr
      putStrLn $ "N! = " ++ take h fnstr ++ " | " ++ drop h fnstr
  | otherwise             = return ()
  where
    fnstr = show $ factorial $ n
    a' = fromIntegral a
    h  = length fnstr - a'

main :: IO ()
main = do
  args <- getArgs               -- IO [String]
{--
  progName <- getProgName       -- IO String
  putStrLn "The Program name is:"
  putStrLn progName
  putStrLn "The arguments are:"
  mapM putStrLn args
--}

  let n = getN args
  if show n `elem` args then
    return ()
    else
    die "Could not find N (Not given or Invalid)"

  putStrLn $ "Given Number: " ++ show n
  let answer = sum [ nthRootOfFive x | x <- [ 1 .. n ] ]
  printGenTrim args n answer
  putStrLn $ "Answer: " ++ show answer
