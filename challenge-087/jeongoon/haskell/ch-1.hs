import System.Environment
import System.Exit
import Data.Char (isNumber)
import Data.Maybe (catMaybes)
import Data.List (sort, sortBy)

{- tested with: runhaskell ch-1.hs  1 3 2 -1 -2 -3 6 7 9 1
(only shows one answer)
-}

answerLongestConsecutiveSequence :: [Int] -> [Int]
answerLongestConsecutiveSequence =
  ( head
  . sortBy (\a b -> (length b) `compare` (length a))
  . consecutiveSequences )

  where
    consecutiveSequences =
      ( scanl1 (\a b -> if (head b)-(last a) == 1 then (a++b) else b)
        . map (:[])
        . sort )

main = do
    (catMaybes.map (\nStr ->
                       if (all isNumber nStr) then Just(read nStr :: Int)
                       else Nothing )) `fmap` getArgs
      >>= (\nums ->
              if length nums < 1 then
                die "Usage: runhaskell ch-1.hs <integer> ..."
              else
                putStrLn $ show ( answerLongestConsecutiveSequence nums ) )
