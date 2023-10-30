module Ch2 where

consistentStrings :: [String] -> String -> Int
consistentStrings xs allowed =
  length $ filter (==True) $ map (\s -> cond s) xs
  where
    cond s = all (\c -> elem c allowed) s
    
main :: IO ()
main = do
  print $ consistentStrings ["ad","bd","aaab","baa","badab"] "ab"
  print $ consistentStrings ["a","b","c","ab","ac","bc","abc"] "abc"
  print $ consistentStrings ["cc","acd","b","ba","bac","bad","ac","d"] "cad"

