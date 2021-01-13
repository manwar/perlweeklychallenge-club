import System.IO
import Data.List (all, nub, groupBy, sortOn,
             replicate, permutations, mapAccumL)
import Data.Char (isNumber)

{- tested with:
echo -e "[1 2 3][4 5 6][7 8 9]" | runhaskell ch-1.hs
-}

data LinearMatrix2D = LinearMatrix2D { getNumRows :: Int,
                                       getNumCols :: Int,
                                       getVector  :: [Int] } deriving (Eq, Show)

getLinearMatrixFromStdin = fmap (parseLinearMatrix.getMatrixLines) getContents where
    getMatrixLines = filter (all (`elem` " "++"0123456789")) .
                     groupBy (\a b -> (isNumber a) && b `notElem` "]\n")
                     -- groupBy get two vars to compare to determine
                     -- whether thery are the same or not.
    parseLinearMatrix mlines =
      let vec = parseAsArray mlines in
        LinearMatrix2D { getNumRows = length mlines,
                         getNumCols = (length vec `div` length mlines),
                         getVector  = vec }
    parseAsArray :: [String] -> [Int]
    parseAsArray = foldr (\x acc -> (parseEachLine x) ++ acc) []
    parseEachLine = map (\c -> read c :: Int ) . filter (all isNumber)
                    . groupBy (\a b -> all isNumber [a,b])

type Sum  = Int
type Trace = [Int]
type PathOffset = [Int]

getAllPathSum :: LinearMatrix2D -> [(Sum, Trace)]
getAllPathSum lm = (map (\t -> (sum t, t)) . map getTrace) allPaths where
  matvec = getVector lm -- lm: linear matrix
  allPaths :: [PathOffset]
  allPaths = {- a simple way to make
                (combi: choose n from m) X (combi: choose n' from m') -}
    (nub.permutations)
    ((replicate numColOffset 1) ++ (replicate numRowOffset rowOffset))

  rowOffset = getNumCols lm
  numColOffset = (getNumCols lm) -1
  numRowOffset = (getNumRows lm) -1
  getTrace :: PathOffset -> Trace
  getTrace path = snd getTrace' ++ [ (head.fst) getTrace' ] where
    getTrace' = mapAccumL (\l b -> let l' = drop b l in (l', head l))
                  matvec path

main = do
  lmatrix <- getLinearMatrixFromStdin
  putStrLn "All Possible ways are:"
  mapM_ print $ getAllPathSum lmatrix
  let minPaths = (head.groupBy (\(a,_) (b,_) -> a == b).
                sortOn fst.getAllPathSum) lmatrix in do
    putStrLn "All possible minimum sum paths are:"
    mapM_ print minPaths
    putStr $ "Therefore the minimum sum is: " ++ ((show.fst.head) minPaths)
