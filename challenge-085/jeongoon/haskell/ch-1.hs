import System.Environment
import System.Exit
import Data.Char (isNumber)
import Data.Maybe (catMaybes)
import Data.List (find, intercalate)
import Combinations (combinations)

{- tested with:
runhaskell ch-1.hs 0.8 0.4 1.2 0.9 1.7 0.2
1 as 1.0 < (0.8 + 0.4 + 0.2) < 2.0
-}

answerTripletSum :: [Float] -> Maybe [Float]
answerTripletSum fs
  | length fs < 3 = Nothing
  | otherwise = findTriplet
    where
      findTriplet =
        find (\tr ->
                 let trsum = sum tr
                 in 1.0 < trsum && trsum < 2.0) (combinations fs 3)

showAnswerDetail_ :: Maybe [Float] -> String
showAnswerDetail_ fs' =
  case fs' of
    Nothing -> "0"
    Just fs -> "1 as 1.0 < (" ++ ((intercalate " + " .
                                  map show) fs) ++ ") < 2.0"

main = do
    (catMaybes.map (\fStr ->
                       if ((all (\c -> (isNumber c) || c == '.') fStr)
                         && length(filter (=='.') fStr) <= 1)
                       then Just(read fStr :: Float)
                       else Nothing )) `fmap` getArgs
      >>= (\rnums ->
              if length rnums < 1 then
                die "Usage: runhaskell ch-2.hs <real num> ..."
              else
                (putStrLn .
                 showAnswerDetail_ .
                 answerTripletSum ) rnums )
