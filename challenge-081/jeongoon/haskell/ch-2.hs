import System.Environment
import System.IO (readFile)
import System.Exit
import qualified Data.Map.Strict as M
import qualified Data.Text as T
import Data.Map.Strict (Map)

{- test with: cd jeongoon/haskell; runhaskell ./ch-2.hs; cd -
-}

{- comment:
   when using Data.Text, it becomes allmost twice faster than regular [Char]
   complie with: ghc -O2 ch-2
   tested with ./ch-2

   but still slower than compiled version of ch-2.go
-}

frequencyFromList :: [T.Text] -> Map T.Text Integer
frequencyFromList = foldr (\x acc -> M.insertWith (+) x 1 acc) M.empty

invertedFrequency :: Map T.Text Integer -> Map Integer [T.Text]
invertedFrequency =
  (foldr (\(word,freq) acc ->
        M.insertWith (++) freq [word] acc) M.empty) . M.toList

filterStrings :: [T.Text] -> T.Text -> T.Text
filterStrings [] txt = txt
filterStrings wholeFilters txt = filterStrings' T.empty wholeFilters txt where
  filterStrings' filtered filters remains
    | T.null remains = filtered -- no more string left to filter
      -- start over due to nothing filtered at this position
    | null filters = filterStrings' filtered' wholeFilters rs
      -- apply a filter one by one
    | beingFiltered = filterStrings' filtered wholeFilters remains'

    | otherwise = filterStrings' filtered fs remains
    where
      f             = head filters
      fs            = tail filters
      Just (r, rs)  = T.uncons remains
      filtered'     = T.append filtered (T.singleton r)
      lenF          = T.length f
      beingFiltered = (T.take lenF remains) == f
      remains' = T.drop lenF remains

main = do
  readFile "input" >>=
    return.
    M.toList.
    invertedFrequency.
    frequencyFromList.
    T.words.
    filterStrings'.
    T.pack
    >>=
    mapM_ (\(frq,wordls) ->
             putStrLn $ (show frq) ++ "\t" ++ ((T.unpack . T.unwords) wordls))
  where filterStrings' = filterStrings ((T.words.T.pack) ". , ( ) -- 's \"")
