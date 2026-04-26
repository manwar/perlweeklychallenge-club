import qualified Data.Map.Strict as Map
import Data.Function
import Data.Char
import Data.List
import Data.Ord

popularWord :: String -> [String] -> String
popularWord paragraph banned = Map.difference (tally twords) (tally banned)
                             & Map.toList
                             & maximumBy (comparing snd)
                             & fst
    where
        replace :: String -> (Char -> Bool) -> Char -> String
        replace  [] _ _ = []
        replace (c:cs) p r
            | p c       = r : replace cs p r
            | otherwise = c : replace cs p r

        twords = replace paragraph isPunctuation ' '
               & map toLower
               & words

        -- there is probably a built in function for this
        tally :: Ord a => [a] -> Map.Map a Int
        tally s = foldl (updateWith (+1) 1) Map.empty s
            where
                updateWith :: Ord k => (v -> v) -> v -> Map.Map k v -> k -> Map.Map k v
                updateWith f def map key
                    | Map.member key map = Map.adjust f key map
                    | otherwise          = Map.insert key def map

main :: IO ()
main = do
    print $ popularWord "Bob hit a ball, the hit BALL flew far after it was hit." ["hit"]             == "ball"
    print $ popularWord "Apple? apple! Apple, pear, orange, pear, apple, orange." ["apple", "pear"]   == "orange"
    print $ popularWord "A. a, a! A. B. b. b." ["b"]                                                  == "a"
    print $ popularWord "Ball.ball,ball:apple!apple.banana" ["ball"]                                  == "apple"
    print $ popularWord "The dog chased the cat, but the dog was faster than the cat." ["the", "dog"] == "cat"
