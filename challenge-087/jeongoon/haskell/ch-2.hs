import System.Exit
import Data.List (isPrefixOf, groupBy, subsequences, union
                 , intersperse, replicate)
import Data.Char (digitToInt)
import qualified Data.Map as M

{- tested with:
echo '[000111][111111][001001][001111][001111]' | runhaskell ch-2.hs

-}

-- solution
getMatrixFromStdin :: IO [[Int]]
getMatrixFromStdin =  (  convertToInteger
                        -- . filterEmptyRow
                        . parseMatrixLines
                        . toMatrixLines    ) `fmap` getContents
  where
    parseMatrixLines = map (filter (not.isPrefixOf " ").
                            groupBy (\a b -> a == ' ' && a == b).
                            filter (\c -> c `elem` " 10"))
    toMatrixLines       =  lines . unlines . groupBy (\_ b -> b /= ']')
    --filterEmptyRow      = filter ((0/=).length)
    convertToInteger    = map (map (\x -> (map digitToInt x)!!0))

 -- a line between column A to B
data ConsecutivePoints  = ConsecutivePoints { begin :: Int,
                                              end   :: Int }
                        deriving (Eq, Ord, Show)

groupByConsecutiveNumber_ :: (Eq a, Num a) => [a] -> [[a]]
groupByConsecutiveNumber_ =
  foldl (\acc x -> if ((not.null) acc)
                   then if (x -(last (last acc))) == 1
                        then (init acc) ++ [(last acc) ++ [x]]
                        else acc ++ [[x]]
                   else [[x]] ) []

getConsecutivePointsFromMatrix :: [[Int]] -> [(ConsecutivePoints, Int)]
getConsecutivePointsFromMatrix =
  ( foldr (\x acc -> let (pts, r) = x
                     in acc ++ (map (\p -> (p, r)) pts) ) []
    . zipWithRowNum -- ->  [([ConsecutivePoints], Int)]
    . map (  map toConsecutivePoints
             . consecutiveLinesFromIndices
             . binariesToIndices ) )
  where
    subsequences' = filter ((0<).length) . subsequences
    binariesToIndices :: [Int] -> [Int]
    binariesToIndices row = foldl (\acc x -> if ((1==).snd) x
                                    then acc ++ [(fst x)]
                                    else acc ) [] (zip [0..] row)
    consecutiveLinesFromIndices :: [Int] -> [[Int]]
    consecutiveLinesFromIndices =  ( foldr (++) [] -- flatten
                                     . map subsequences'
                                     . groupByConsecutiveNumber_ )
    zipWithRowNum = (flip zip) [0..]

    toConsecutivePoints :: [Int] -> ConsecutivePoints
    toConsecutivePoints = (\xs -> ConsecutivePoints (head xs) (last xs))

groupByConsecutivePoints :: [(ConsecutivePoints, Int)]
                         -> [(ConsecutivePoints,[Int])]
groupByConsecutivePoints ls = (M.toList . M.fromListWith union)
                              $ map (\(k,v) -> (k,[v])) ls

groupByArea :: [(ConsecutivePoints, [Int])]
            -> [((ConsecutivePoints, [Int]), Int)]
groupByArea =
  foldr (++) []
  . map (\(ps , rs) ->
           map (\rs' -> ((ps, rs'), ((length rs')
                                     * ((end ps) - (begin ps) + 1))))
          (groupByConsecutiveNumber_ rs))

findMaximumAreas :: [((ConsecutivePoints, [Int]), Int)]
             -> [((ConsecutivePoints, [Int]), Int)]
findMaximumAreas = foldr (\x@(_, area) acc ->
                        let maxarea = if null acc then 0
                                      else (snd.head) acc
                        in if area > maxarea then [x]
                           else if area == maxarea then acc ++ [x]
                                else acc) []
showMaxAreas :: [((ConsecutivePoints, [Int]), Int)] -> [[String]]
showMaxAreas =
  map (\((cpts, rs), area) ->
           if area == 1 then []
           else let nc = (end cpts) - (begin cpts) + 1
                    nr = length rs
                in (replicate nr.intersperse ' '. replicate nc) '1')

-- testing
main = do
  aSample <- getMatrixFromStdin;
  putStrLn "Given Matrix:"
  mapM_ (putStrLn.unwords.map show) aSample

  if length aSample < 1
    then die "0 as given data is not sufficient"
    else let visibleMaxAreas = ( showMaxAreas
                                 . findMaximumAreas
                                 . groupByArea
                                 . groupByConsecutivePoints
                                 . getConsecutivePointsFromMatrix ) aSample
         in if null visibleMaxAreas then putStrLn "0"
            else mapM_ (mapM_ putStrLn) visibleMaxAreas
