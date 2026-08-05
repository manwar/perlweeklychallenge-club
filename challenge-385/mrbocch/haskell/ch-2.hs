
outerMostParen :: String -> String
outerMostParen = map fst 
               . filter ((/= 1) . snd)
               . flip step 0 
  where 
    step :: String -> Int -> [(Char, Int)]
    step ('(':xs) lvl = ('(', lvl+1) : step xs (lvl+1)
    step (')':xs) lvl = (')', lvl)   : step xs (lvl-1)
    step "" _         = []


main :: IO ()
main = do
  print $ outerMostParen "()()()"         == ""
  print $ outerMostParen "(((())))"       == "((()))"
  print $ outerMostParen "(()())(())"     == "()()()"
  print $ outerMostParen "()((()))()"     == "(())"
  print $ outerMostParen "(()(()))(()())" == "()(())()()"


