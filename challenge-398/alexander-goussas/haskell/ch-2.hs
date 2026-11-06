module Main where

import           Control.Exception (assert, evaluate)
import           Data.Char         (ord)
import           Data.Function     (on)
import           Data.List         (groupBy, sortOn)
import           Data.Ord          (comparing)

diff :: String -> [Int]
diff xs =
  let xs' = map ord xs
  in map (uncurry $ flip (-)) $ zip xs' (tail xs')

solve :: [String] -> String
solve xs
  = head
  . map (fst . head)
  . filter ((==) 1 . length)
  . groupBy (\(_, ys) (_, zs) -> ys == zs)
  . sortOn snd
  $ zip xs (map diff xs)

main :: IO ()
main = do
  evaluate $ assert (solve ["ab", "bc", "cd", "zy"] == "zy") ()
  evaluate $ assert (solve ["cba", "fed", "azy"] == "azy") ()
  evaluate $ assert (solve ["pop", "ada", "beb", "cfc"] == "pop") ()
  evaluate $ assert (solve ["aaaa", "zzzz", "mmmm", "aaba"] == "aaba") ()
  evaluate $ assert (solve ["aceg", "bdfh", "cegi", "azbz"] == "azbz") ()
