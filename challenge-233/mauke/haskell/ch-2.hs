import Data.List (sortBy)
import qualified Data.Map.Strict as M
import Data.Ord (comparing)
import System.Environment (getArgs)

histo :: (Ord a) => [a] -> M.Map a Int
histo = M.fromListWith (+) . map (flip (,) 1)

freqSort :: (Ord a) => [a] -> [a]
freqSort xs = sortBy (comparing (seen M.!) <> flip compare) xs
    where
    seen = histo xs

main :: IO ()
main = print . freqSort . map (read :: String -> Int) =<< getArgs
