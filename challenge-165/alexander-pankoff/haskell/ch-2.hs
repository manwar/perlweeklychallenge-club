module Main where

import Plot (Line (..), Plot (plotPoints), Point (Point, x), ToXML (toXML), addLine, parsePlot)
import System.Exit (exitFailure)
import System.IO (hPutStrLn, stderr)

pointInput :: String
pointInput = "333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193 341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102 284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169 128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86 215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186 275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89"

main :: IO ()
main = do
  either
    (\err -> putErrLn (show err) >> exitFailure)
    (putStr . toXML . addLineOfBestFit)
    (parsePlot $ words pointInput)

putErrLn :: String -> IO ()
putErrLn = hPutStrLn stderr

-- Line of Best Fit

addLineOfBestFit :: Plot -> Plot
addLineOfBestFit p =
  addLine (bestFittingLine $ plotPoints p) p

bestFittingLine :: [Point] -> Line
bestFittingLine ps =
  let lineEq = leastSquaresRegression ps
      (minX, maxX) = minmax $ map x ps
   in Line
        (Point minX $ lineEq minX)
        (Point maxX $ lineEq maxX)

leastSquaresRegression :: [Point] -> LineEq
leastSquaresRegression ps =
  let n = fromIntegral $ length ps
      (sx, sy, sxs, sxy) =
        foldl
          ( \(sx, sy, sxs, sxy) (Point x y) ->
              (sx + x, sy + y, sxs + x ^ 2, sxy + x * y)
          )
          (0, 0, 0, 0)
          ps
      m = (n * sxy - sx * sy) / (n * sxs - sx ^ 2)
      b = (sy - (m * sx)) / n
   in \x -> m * x + b

type LineEq = Double -> Double

minmax :: Ord a => [a] -> (a, a)
minmax = (,) <$> minimum <*> maximum