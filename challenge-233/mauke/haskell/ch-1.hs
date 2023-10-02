import Data.List (group, sort)
import System.Environment (getArgs)

main :: IO ()
main = print . countPairs =<< getArgs
    where
    countPairs = sum . map (triangle . length) . group . sort . map (map head . group . sort)
    triangle n = n * pred n `div` 2
