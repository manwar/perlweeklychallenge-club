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

factorial :: Int -> Integer
factorial x = product [ 1.. fromIntegral x ]

nthRootOfFive :: Integer -> Int
nthRootOfFive x
  | x `mod` 5 /= 0  = 0
  | otherwise       = 1 + nthRootOfFive ( x `div` 5 )

getN :: [String] -> Int
getN []     = 0
getN (x:xs) = if all isNumber x then read x :: Int else getN xs

printGenTrim :: [String] -> Int -> Int-> IO ()
printGenTrim x n a
  | ( "--show-divided" `elem` x ) = do
      putStrLn $ "N! = " ++ fnstr
      putStrLn $ "N! = " ++ take h fnstr ++ " | " ++ drop h fnstr
  | otherwise             = return ()
  where
    fnstr = show $ factorial n
    a' = fromIntegral a
    h  = length fnstr - a'

calculateTrailingZero :: Int -> Int
calculateTrailingZero n = sum [ nthRootOfFive $ fromIntegral x | x <- [1 .. n] ]

bruteforceTrailingZero :: Int -> Int
bruteforceTrailingZero n =
  length $ takeWhile (\x -> nFact `mod` x == 0) (map (10^) [(1::Integer)..])
  where nFact = factorial $ fromIntegral n

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

  putStrLn  $ "Given Number: " ++ show n
  let answer  =  calculateTrailingZero n
  let answer' = bruteforceTrailingZero n
  printGenTrim args n answer
  putStrLn $ "Calcuated:   " ++ show answer
  putStrLn $ "BruteForced: " ++ show answer'
