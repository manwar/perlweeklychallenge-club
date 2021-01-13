--{-# LANGUAGE DeriveGeneric     #-}
--{-# LANGUAGE OverloadedStrings #-}
--import Options.Generic
import System.IO

import Data.List (lines, isPrefixOf, groupBy)
import Data.Char (toUpper)
import Data.Maybe (isJust, fromJust)

{- tested with:
echo -e "[O O X]\n[X O O]\n[X O O]" | runhaskell ch-2.hs
# or even without space
echo -e "[OOXO][XOOO][XOOX][OXXOO]" | runhaskell ch-2.hs
-}
-- solution
getMatrixFromStdin :: IO [[Int]]
getMatrixFromStdin =
  getContents >>= matrixLines >>= return . map parseMatrixLine
  >>= return . map (map (\x -> case toUpper( x!!0 ) of
                           'O' -> 1
                           'X' -> 0
                           _   -> 1)) -- convert into integer
  >>= return . filterEmptyRow
  where
    parseMatrixLine = filter (not.isPrefixOf " ").
                       groupBy (\a b -> a == ' ' && a == b).
                       filter (\c -> c `elem` " OX")
    matrixLines = return . lines . unlines . groupBy (\a b -> b /= ']')
    filterEmptyRow = filter ((0/=).length)

getMatrixValueAt matrix (r, c)
  | length matrix <= r || r < 0 = Nothing
  | length (matrix!!r) <= c || c < 0 = Nothing
  | otherwise = Just $ (matrix!!r)!!c

getPosAroundAt (r, c) = foldr (++) [] -- flatten once
  [ [ (r,c) | c <- [(c-1) .. (c+1)] ] | r <- [(r-1) .. (r+1)] ]

getSumAroundAt matrix (r, c) =
  sum $ map (\(r',c') ->
         case getMatrixValueAt matrix (r',c') of
           Nothing -> 1
           Just  v -> v ) $ getPosAroundAt (r,c)

data RowStatus = RowStatus { r :: Int, c :: Int,
                             val :: Maybe Int,
                             lsum  :: Int } deriving (Eq, Show)

getAllSumAround matrix =
  let maybeNumRows = if length matrix == 0 then Nothing else Just (length matrix)
      maybeNumColumns = case maybeNumRows of
                     Nothing -> Nothing
                     Just nr -> if length (matrix!!0) == 0 then Nothing
                               else Just( length (matrix!!0) )
  in
    if isJust maybeNumRows && isJust maybeNumColumns then
      let numRows = fromJust( maybeNumRows )
          numColumns = fromJust( maybeNumColumns ) in
        foldr (++) [] -- flatten once
        [ [ RowStatus { r = ri, c = ci,
                        val  = (getMatrixValueAt matrix (ri,ci)),
                        lsum = (getSumAroundAt matrix (ri,ci)) }
          | ci <- [0..numColumns] ] | ri <- [0..numRows] ]
    else []

isLonenlyX rowst = isJust (val rowst)  && (fromJust (val rowst)) == 0
                   && (lsum rowst) == 8
filterLonelyX = (filter isLonenlyX).getAllSumAround
showRowStatus :: RowStatus -> String
showRowStatus rowst = "Lonely X at row " ++ ((show.r) rowst) ++ ", column "
                      ++ ((show.c) rowst)

-- testing
main = do
  aSample <- getMatrixFromStdin
  putStrLn "Given Matrix ( O -> 1,  X -> 0 ):"
  mapM_ (putStrLn.unwords.map show) aSample
  let theLonelyX = filterLonelyX aSample in
    do
      putStr "Total Lonely X: "
      putStrLn $ (show.length) theLonelyX
      putStrLn "Details are: "
      mapM_ (putStrLn.showRowStatus)  theLonelyX
