import System.Environment
import System.Exit
import Data.List (unfoldr, zipWith3)
import Data.Char (isNumber)
import Data.Maybe (isNothing, catMaybes)

-- tested with: runhaskell ch-2.hs 2 1 4 1 2 5 6 8 2 1 3 4 8 1 3 2 9 3 7 3 1 2

trappedRainWaterData hs
  | length hs < 3 = Nothing
  | otherwise =
    let  lefts  = (tail.scanl1 max.init) hs
         rights = (init.scanr1 max.tail) hs
         mids = (init.tail) hs
    -- padding front and back with zero to match the length of histogram
    in Just $ 0 : (zipWith3 (\l m r -> (min l r) - m) lefts mids rights) ++ [0]

-- modified from ch-075 :: ch-2.hs
printHistogramWithWater :: [Int] -> [Int] -> IO ()
printHistogramWithWater  hdata wdata = do
  mapM_ putStrLn lineBuffers where
    hdataLen    = length hdata
    maxH        = maximum hdata
    lineBuffers = unfoldr forYaxis maxH
    forYaxis (y)
      -- footer
      | y ==  0   = Just( replicate (wordWidth * (hdataLen +1)) '_',  y-1 )
      | y == -1   = Just( whiteSpace
                         ++ (foldl (\acc x ->
                                   acc ++ (fixedNumber x)) "" hdata) , y-1 )
      | y < -1   = Nothing
      -- data
      | otherwise = Just( yScale ++ allColumnData, y-1 )
      where
        wordWidth  = ((length.show) maxH) +1
        whiteSpace = replicate wordWidth ' '
        yScale     = fixedNumber y
        fixedNumber   n = (preWhiteSpace n) ++ (show n)
        padding         = (replicate (wordWidth - 1) ' ')
        sharpMark       = padding ++ ['#']
        waterMark       = padding ++ ['~']
        preWhiteSpace n = replicate (wordWidth - (length (show n))) ' '
        allColumnData   =
          foldl (\acc (h, w) ->
               acc ++ (if h >= y
                        then sharpMark
                        else if (h+w) >= y then waterMark else whiteSpace )) ""
          (zip hdata wdata)

main = do
  hdata <- (catMaybes.map (\nStr ->
                              if (all isNumber nStr) then Just(read nStr :: Int)
                              else Nothing )) `fmap` getArgs;
    let maybeWdata = trappedRainWaterData hdata in
      case maybeWdata of
        Nothing -> putStrLn "Too short histogram data (lenght must be> 2)"
        Just wdata -> do
          putStrLn $ "Total capacity: " ++  ((show.sum) wdata)
          printHistogramWithWater hdata wdata
