
import Data.Function
import Data.Set (Set)
import qualified Data.Set as Set

infixr 8 .:
(.:) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
(f .: g) a b = f (g a b)

count :: (a -> Bool) -> [a] -> Int
count = length .: filter

adjacentGenes :: String -> String -> Bool
adjacentGenes = (== 1)
                .  count not
                .: zipWith (==)

minimumGeneticMutation :: String -> String -> [String] -> Maybe Int
minimumGeneticMutation start end bank = iter [start] (Set.singleton start) 0
  where
    iter :: [String] -> Set String -> Int -> Maybe Int 
    iter nodes seen count 
      | elem end nodes = Just count  
      | null nodes     = Nothing
      | otherwise      = iter adjacent seen' (count+1)
        where
          adjacent :: [String]
          adjacent = concatMap (\n -> filter (adjacentGenes n) bank) nodes
                   & filter (`Set.notMember` seen) 

          seen' :: Set String        
          seen' = seen `Set.union` Set.fromList adjacent

   
main :: IO ()
main = do
  print $ Nothing == minimumGeneticMutation "AACCGGTT" "AACCGGTA" ["AACCGCTA", "AAACGGTA"]
  print $ Just 2  == minimumGeneticMutation "AACCGGTT" "AACCGGAA" ["AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"]
  print $ Nothing == minimumGeneticMutation "AAAAAAAA" "AAAAACCC" ["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"]
  print $ Just 7  == minimumGeneticMutation "GAAAAAAA" "GCCCCCCC" ["GCAAAAAA", "GCCAAAAA", "GCCCAAAA", "GCCCCAAA", "GCCCCCAA", "GCCCCCCA", "GCCCCCCC"]
  print $ Just 0  == minimumGeneticMutation "AACCGGTT" "AACCGGTT" ["AACCGGTA"]

