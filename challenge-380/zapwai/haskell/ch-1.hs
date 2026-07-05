import qualified Data.Map.Strict as M
import Data.List (foldl')
freq :: Ord a => [a] -> M.Map a Int
freq = foldl' (\m x -> M.insertWith (+) x 1 m) M.empty
vowels = "aeiou"
--isVowel c = c `elem` vowels
main = do
  let cases = ["banana", "teestett", "aeiouuaa", "rhythm", "x"]
  mapM_ handle cases
    where
      handle s = do
        putStrLn ("Input: " ++ show s)
        let a = freq s
            vowelCounts =
              [ M.findWithDefault 0 c a | c <- vowels ]
            consonantCounts =
              [ v | (k, v) <- M.toList a, k `notElem` vowels ]
        
        let mv =
              if null vowelCounts
              then 0
              else maximum vowelCounts
        let mc =
              if null consonantCounts
              then 0
              else maximum consonantCounts
            
        putStrLn ("Output: " ++ show (sum [mv, mc]))

