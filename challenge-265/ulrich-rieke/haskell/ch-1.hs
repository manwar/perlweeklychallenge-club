module Challenge265
   where
import qualified Data.Set as S
import Data.List ( sort ) 
import Data.Maybe ( fromJust ) 

findFrequencies :: [Int] -> [(Int, Int)]
findFrequencies list = map (\d -> (d , length $ filter ( == d ) list )) $ 
 S.toList $ S.fromList list

findSelection :: [Int] -> [Int]
findSelection list = filter (\d -> (fromIntegral $ fromJust $ lookup d
 frequencies) >= limit ) list
 where
  frequencies :: [(Int, Int)]
  frequencies = findFrequencies list
  limit :: Double
  limit = (fromIntegral $ length list) / 3.0

main :: IO ( )
main = do
   putStrLn "Enter some integers, separated by blanks!"
   numberline <- getLine
   let numbers = map read $ words numberline
       selection = findSelection numbers
   if not $ null selection then print $ head $ sort selection else
    print "undef"
