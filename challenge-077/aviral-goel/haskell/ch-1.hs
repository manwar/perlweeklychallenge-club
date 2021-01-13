import System.Environment (getArgs)
import Data.List (intercalate)

partitions :: [Int] -> Int -> [[Int]]
partitions _ 0 = [[]]
partitions [] _ = []
partitions (x:xs) n | x <= n = others ++ map (x:) (partitions xs (n - x))
                    | otherwise = others
                    where others = partitions xs n

fibonacci :: [Int]
fibonacci = 0:1: zipWith (+) fibonacci (tail fibonacci)

fibonacciPartitions :: Int -> [[Int]]
fibonacciPartitions n =
  partitions xs n
  where xs = takeWhile (<= n) (tail (tail fibonacci))

toString :: [[Int]] -> String
toString [] = "0"
toString xss =
  intercalate "\n" (map toEquation xss)
  where toEquation xs = intercalate " + " (map show xs) ++ " = " ++ show (sum xs)

main :: IO ()
main = do
  n <- fmap head getArgs
  let xs = fibonacciPartitions (read n)
  let str = toString xs
  putStrLn str
