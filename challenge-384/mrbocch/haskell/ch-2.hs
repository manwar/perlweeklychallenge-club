import Data.Function
import qualified Data.Set as Set

uniq :: Ord a => [a] -> [a]
uniq = go Set.empty
  where
    go _ [] = []
    go s (x:xs)
      | x `Set.member` s = go s xs
      | otherwise        = x : go (Set.insert x s) xs

specialBinarySubstrings :: String -> [String]
specialBinarySubstrings s = [2..length s]
      & filter even
      & concatMap (\x -> windows x s)
      & filter isSpecial
      & uniq
  where 

  windows ::  Int -> [a] -> [[a]]
  windows k xs 
    | k == length xs = [take k xs]
    | otherwise      = (take k xs) : windows k (drop 1 xs)

  isSpecial :: String -> Bool
  isSpecial s = valid l r
    where
      x = split2 s
      l = fst x
      r = snd x 

      valid :: String -> String -> Bool
      valid l r
        | length l /= length r = False
        | otherwise            = valid' l r 

      valid' :: String -> String -> Bool
      valid' l r 
        | all (=='1') l && all (=='0') r = True 
        | all (=='0') l && all (=='1') r = True
        | otherwise                      = False 

      split2 :: [a] -> ([a], [a])
      split2 xs = (l, r)
        where
          ls = quot (length xs) 2
          l = take ls xs
          r = drop ls xs 
