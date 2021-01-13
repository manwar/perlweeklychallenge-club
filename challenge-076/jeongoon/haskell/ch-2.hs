{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
import Options.Generic
import Data.List ( find, findIndex, span, insert, intersectBy, sortBy
            ,inits, tails, isPrefixOf, unfoldr )
import Data.Char ( toLower )
import System.IO

{- tested with:
ghc ch-2.hs
./ch-2 --grid ../data/grid.txt --dict ../data/tinyDict.txt
 # or this will use `/usr/share/dict/british-english' by default
-}

{- comment:
I try to learn how `data' works in Haskell
probably I could have used `nub` for duplicated words
and use `readFile' to get simply a list of words in a dictionary
but try to do more investigation about this interesting language
-}

-- solution:
-- 1. read Grid and generate all possile (and useful) indices
-- 2. save all words accoring to the indcies found above into tree
-- 3. read Dictionary
-- 4. compare one by one
---   all data is sorted so we can easily compare between two.

-- not-efficient tree with multiple child nodes
data WordTree = Root [WordTree] | Node Char [WordTree]
  deriving (Show, Read, Eq, Ord)

wordTreeNodeVal  (Node a _)        = a
wordTreeNodeVal  (Root   _)        = '\NUL'
wordTreeChildren (Root   children) = children
wordTreeChildren (Node _ children) = children

findChild a wtree = find ((a ==).(wordTreeNodeVal)) (wordTreeChildren wtree)
spanChildren c children = span ((<c).(wordTreeNodeVal)) children

newChild        a = Node a [] -- with char
newChildren   str
  | length str == 1  = newChild (head str)
  | otherwise = foldr (\x acc -> Node x [acc]) (newChild (last str)) (init str)

wordTreeSaveWord :: WordTree -> String -> WordTree
wordTreeSaveWord (Root children) str@(c:cs) =
  let (leChildren, riChildren) = spanChildren c children
      foundChild = head riChildren
  in
    if (null riChildren) || ((wordTreeNodeVal.head) riChildren /= c)
    then Root (insert (newChildren str) children)
    else if null cs then Root children -- already saved: skip
      else Root$leChildren ++ (wordTreeSaveWord foundChild cs):(tail riChildren)

wordTreeSaveWord (Node a children) str@(c:cs) =
  let (leChildren, riChildren) = spanChildren c children
      foundChild = head riChildren
  in
    if (null riChildren) || ((wordTreeNodeVal.head) riChildren /= c)
    then Node a (insert (newChildren str) children)
    else if null cs then Node a children -- already saved: skip
      else Node a $ leChildren
                  ++ (wordTreeSaveWord foundChild cs):(tail riChildren)

wordTreeGetAllWords :: WordTree -> [String]
wordTreeGetAllWords (Root children) =
  ((foldr (++) []).(map wordTreeGetAllWords)) children

wordTreeGetAllWords (Node nv children) =
  [[nv]] ++ ((foldr (++) [])
              .(map (\wtree -> [ nv:str | str <-(wordTreeGetAllWords wtree)] )))
  children

-- find out all indices
allColumnIndices (maxPos, llen) =
  map (\c ->  takeWhile (<=maxPos) $
             map ((c+).(llen*)) [ 0 .. (maxPos `div` llen) ] )
  [ 0.. (llen -1) ]

allRowIndices (maxPos, llen) =
  map (\c -> takeWhile (<=maxPos) $
            map (c+) [ 0 .. (llen -1) ] )
  [ 0, llen .. maxPos ]

allTopLeftToBottomRightIndices (maxPos, llen) =
  map (\c -> [c] ++ ( takeWhile
            (\x -> x <= maxPos
              && (rem c llen) < (rem x llen) ) $
            map (c+) [ (llen+1), (llen+llen+2) .. ] ) ) $
  [ 0 .. (llen-1) ] ++ [ llen, llen + llen .. maxPos ]

allTopRightToBottomLeftIndices (maxPos, llen) =
  map (\c -> [c] ++ ( takeWhile
            (\x -> x <= maxPos
              && (rem x llen) < (rem c llen) )
            $ map (c+) [ (llen-1), (llen+llen-2) .. ] ) )
  $ [ 0 .. (llen-1) ] ++ [ llen+llen-1, llen+llen+llen-1 .. maxPos ]

allIndices (maxPos, llen) = let idxArgs = (maxPos, llen) in
                              (allColumnIndices idxArgs)
                              ++ (allRowIndices idxArgs)
                              ++ (allTopLeftToBottomRightIndices idxArgs)
                              ++ (allTopRightToBottomLeftIndices idxArgs)

flatOnce = foldr (++) []

bothDirectAllIndices = flatOnce.(map obverseAndReverse).allIndices where
    obverseAndReverse a
      | length a == 1 = [ a ] -- rerversing is not useful
      | otherwise     = [ a, reverse a ]

-- final result of indices
allUsefulCombinationIndices = {-usefulInits.
  -- note: wordTreeGetAllWords generate all subsequence which begins from
  --       the begining so we can skip generating `inits'
-}
  usefulTails.bothDirectAllIndices where
  -- another possible approach might be (not checked)
  -- (filter ((2<).length).subsequences)
  --usefulInits = flatOnce.map (drop 2. inits)
  usefulTails = flatOnce.map
                ((\ls -> let len = length ls in take (len-2) ls).tails)

data GridData = GridData { gridMaxPos       :: Int
                         , gridLineLength   :: Int
                         , gridContents     :: String       } deriving (Show)

-- grid data
gridDataFromString gridString =
  let noSpaceContents = filter (' '/=) gridString
      lineLen = case (findIndex ('\n'==) noSpaceContents) of
                  Nothing -> 1 -- maybe a wrong formated file: assume one
                  Just ln -> ln
      contents = (map toLower.filter ('\n'/=)) noSpaceContents
      maxPos   = (pred.length) contents
  in GridData { gridLineLength = lineLen
             , gridMaxPos = maxPos
             , gridContents = contents }

allUsefulWordsFromGridData g = (map (map (contents!!))) idcsList
  where
    lineLengh = gridLineLength g
    maxPos    = gridMaxPos     g
    contents  = gridContents   g
    idcsList  = allUsefulCombinationIndices (maxPos, lineLengh)

wordTreeFromGridData =
  (foldr (flip wordTreeSaveWord) (Root [])).allUsefulWordsFromGridData

-- comparison
grepMatched dictWords gridWords = impli dictWords gridWords [] where
  impli _ [] matchedWords = matchedWords
  impli [] _ matchedWords = matchedWords
  impli dw@(d:ds) gw@(g:gs) matchedWords =
    case ((map toLower d) `compare` g) of -- grid words already in lower case
      LT -> impli ds gw matchedWords
      EQ -> impli ds gs (matchedWords ++ [d])
      GT -> impli dw gs matchedWords

defaultGridFile   = "../data/grid.txt"
--defaultDictionary = "../tinyDict.txt"
defaultDictionary = "/usr/share/dict/british-english"
-- via `words' package in Arch Linux

-- testing ...
data Sample = Sample { grid :: Maybe FilePath, dict :: Maybe FilePath }
  deriving (Generic, Show)
instance ParseRecord Sample

main = do
  args <- getRecord "Challennge #076 - Task #2"
  let sample = args :: Sample
      gridPath = case (grid sample) of
                   Nothing -> defaultGridFile
                   Just gp -> gp
      dictPath = case (dict sample) of
                   Nothing -> defaultDictionary
                   Just dp -> dp
    in do
    rawData  <- readFile gridPath
    dictData <- readFile dictPath

    putStrLn $ "Grid Contents:\n" ++ rawData
    let gridWords = (wordTreeGetAllWords
                    .wordTreeFromGridData
                    .gridDataFromString) rawData
        dictWords = sortBy (\a b ->
                              compare (map toLower a) (map toLower b)
                           ) $ lines dictData
        matchedWords = grepMatched dictWords gridWords
      in do
      putStrLn $ "Total " ++ (show (length gridWords))
        ++ " possible words in grid."
      print matchedWords
      putStrLn $ "\nTotal "
        ++ (show (length matchedWords)) ++ " word(s) found."

-- ok ok ...
