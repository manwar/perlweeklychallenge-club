import System.Exit
import Data.List (isPrefixOf, groupBy, sort)
import Data.Char (digitToInt)
import qualified Data.Map as M

{- tested with:
echo '[101][110][011] ' | runhaskell ch-2.hs
# -> 0
echo '[1101][1100][0111][1011]' | runhaskell ch-2.hs
# -> 4
-}

-- solution
combi2 [_]    = []
combi2 [e,f]  = [[e,f]]
combi2 (m:ms) = sequence [[m], ms] ++ (combi2 ms)

getMatrixFromStdin :: IO [[Int]]
getMatrixFromStdin =  (  convertToInteger
                        . filterEmptyRow
                        . parseMatrixLines
                        . toMatrixLines    ) `fmap` getContents
  where
    parseMatrixLines = map (filter (not.isPrefixOf " ").
                            groupBy (\a b -> a == ' ' && a == b).
                            filter (\c -> c `elem` " 10"))
    toMatrixLines       =  lines . unlines . groupBy (\_ b -> b /= ']')
    filterEmptyRow      = filter ((0/=).length)
    convertToInteger    = map (map (\x -> (map digitToInt x)!!0))

 -- a line between column A to B
data HLine  =  HLine Int Int deriving (Eq, Ord, Show)
-- two same HLine at rows of A and B
data Square =  Square HLine Int Int deriving (Eq, Ord, Show)

getHorizLines :: [[Int]] -> [(HLine, Int)]
getHorizLines matrix = getHorizLines' matrix 0
  where
    getHorizLines' []     _  = []
    getHorizLines' (r:rs) ri = (getAllLinesIn r ri)
                               ++ (getHorizLines' rs (ri+1))
    getAllLinesIn :: [Int] -> Int -> [(HLine, Int)]
    getAllLinesIn row ri = map (\cs -> let cs' = sort cs
                                       in  (HLine (cs'!!0) (cs'!!1), ri))
                           ((combi2 . map fst . filter ((1==) . snd))
                            (zip [0..] row))

findSquaresFromLines :: [(HLine, Int)] -> [Square]
findSquaresFromLines = (   findSquaresFrom
                         . lineToPairOfRowNums
                         . classifiedByLine )
  where
    findSquaresFrom = M.foldrWithKey
                      findPairsMakingSquare []

    findPairsMakingSquare :: HLine -> [[Int]] -> [Square] -> [Square]
    findPairsMakingSquare hl@(HLine x1 x2) pairsRowNums acc =
      acc ++ (map (\xs -> Square hl (xs!!0) (xs!!1))
              (filter (\rs -> -- note: rs is sorted when made
                         let lineLen  = abs $ (x2-x1)
                             distance = abs $ (foldr1 (flip (-)) rs)
                         in lineLen == distance ) pairsRowNums))

    lineToPairOfRowNums :: M.Map HLine [Int] -> M.Map HLine [[Int]]
    lineToPairOfRowNums = M.map combi2
    classifiedByLine ls = M.fromListWith (++) $ map (\(k,v) -> (k,[v])) ls

-- testing
main = do
  aSample <- getMatrixFromStdin;
  putStrLn "Given Matrix:"
  mapM_ (putStrLn.unwords.map show) aSample
  if length aSample < 2
    then die "0 as Number of Rows is less than 2: unable to make any squares."
    else let squares = (findSquaresFromLines . getHorizLines) aSample
         in do putStrLn $ "\n" ++ ((show.length) squares) ++ " squares found:\n"
               mapM_ print squares
