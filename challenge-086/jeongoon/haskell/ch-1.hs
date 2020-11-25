import System.Environment
import System.Exit
import Data.Char (isNumber)
import Data.Maybe (isNothing, catMaybes)
import Data.List (sort)

{- tested with:
runhaskell ch-1.hs  1 3 2 -1 -2 -3 6 7 9 1
1 as 3 - 2 = 1
-}

usageMessage = "Usage: runhaskell ch-1.hs "
               ++ "<target diff(positive integer)> <integer> ..."

pairDifference _      [] = Nothing
pairDifference target ls = pairdiff target (head sorted) (tail sorted) 1
  where
    sorted = sort ls
    pairdiff _ _ [] _ = Nothing
    pairdiff t f rst@(r:_) i = -- t: target, f: first, i: index
      if i >= (length rst) then Nothing
      else case ((rst !! i) - f) `compare` t of
             LT -> pairdiff t f rst (succ i)
             GT -> pairdiff t r rst 1
             EQ -> Just (f, (rst !! i))

main = do
    (catMaybes.map (\nStr ->
                      -- poor parser
                       if (all (`elem` "0123456789+-") nStr)
                       then Just(read nStr :: Int)
                       else Nothing )) `fmap` getArgs
      >>= ( \ints ->
             let d = (head ints) in
               if (length ints) < 2
               then die usageMessage
               else if d < 0
               then die usageMessage
               else case pairDifference d (tail ints) of
                 Nothing    -> putStrLn "0"
                 Just (a,b) -> putStrLn $ "1 as " ++ (show b) ++ " - "
                               ++ (show a) ++ " = " ++ (show d) )
