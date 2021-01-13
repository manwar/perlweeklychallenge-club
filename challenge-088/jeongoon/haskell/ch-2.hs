import Data.List (groupBy, transpose, unfoldr)
import Data.Maybe (catMaybes)

{- tested with:
echo "[a b c d][e f g h][i j k l]" | runhaskell ch-2.hs
echo "[1 2 3][4 5 6][7 8 9]" | runhaskell ch-2.hs
echo "[a b][c d][e f]" | runhaskell ch-2.hs
-}

getMatrixFromStdin :: IO [[String]]
getMatrixFromStdin =
  ( map words
    . filter ((0/=).length)             -- 5. (after 3) there is some empty row
    . map (filter (`notElem` "[]"))     -- 4. '[', ']' is not used
    . lines                             -- 3. devide it into rows
    . unlines                           -- 2. make it "]\n"
    . groupBy (\_ b -> b/= ']') )       -- 1. devide row by "]"
  `fmap` getContents

-- cut outside of a matrix
getInnerMatrix :: [[String]] -> Either String [[String]]
getInnerMatrix m
  | length m <= 1 = Left "Too Short In Row"
  | otherwise = mapCutColumns [] getShorterInRows
    where
      mapCutColumns acc [] = Right acc
      mapCutColumns acc (r:rs) =
        case getShorterInCols r of
          Nothing -> Left "Too Short In Column"
          Just r' -> mapCutColumns (acc ++ [r']) rs
      getShorterInRows = (init.tail) m -- cut top and bottom
      getShorterInCols row =
        if (length row) <= 1 then Nothing
        else Just $ (init.tail) row

-- read outside cells starting from (0,0) in clockwise
readAroundMatrixCW :: [[String]] -> [String]
readAroundMatrixCW [] = []
readAroundMatrixCW m =
  foldr1 (++) $
  getNorth
  : case findEast of
      Nothing -> []
      Just  e -> e
        : case findSouth of
            Nothing -> []
            Just  s -> s
              : case findWest of
                  Nothing -> []
                  Just  w -> [w]
  where
    tm = transpose m
    getNorth  = head m
    findEast  = if (length m) == 1 then Nothing
                else Just $ (tail.last) tm
    findSouth = {-if (length m) == 1 then Nothing
                else-} -- already checked when findEast
      let lm = (last m)
      in if (length lm) == 1 then Nothing
         else Just $ (reverse.init) lm
    findWest  = {-if (length m) == 1 then Nothing
                else-}
      let htm = (head tm)
      in if (length htm) <= 2 then Nothing
         else Just $ (reverse.tail.init) htm

getSpiralAarray :: [[String]] -> [String]
getSpiralAarray mat =
  foldr1 (++)
  ( unfoldr (\m ->
                 case m of
                   Nothing -> Nothing
                   Just m' -> case (getInnerMatrix m') of
                                Left  _   -> Just (outOf m', Nothing)
                                Right m'' -> Just (outOf m', Just m''))
      (Just mat) )
  where outOf m = readAroundMatrixCW m

main = do
  getSpiralAarray `fmap` getMatrixFromStdin
  >>= print
