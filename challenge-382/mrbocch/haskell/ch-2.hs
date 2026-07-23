 
replaceQuestionMark:: String -> [String]
replaceQuestionMark = go
  where
    go :: String -> [String] 
    go [] = []
    go "0" = ["0"]
    go "1" = ["1"]
    go "?" = ["0", "1"]

    go ('0':xs) = prepAll '0' (go xs)
    go ('1':xs) = prepAll '1' (go xs)

    go ('?':xs) = prepAll '0' (go xs) ++
                  prepAll '1' (go xs)

    prepAll :: Char -> [String] -> [String]
    prepAll c = map ((:) c) 

main :: IO ()
main = do
  print $ replaceQuestionMark "" == []
  print $ replaceQuestionMark "01??0" == ["01000","01010","01100","01110"]
  print $ replaceQuestionMark "101"   == ["101"]
  print $ replaceQuestionMark "???"   == ["000","001","010","011","100","101","110","111"]
  print $ replaceQuestionMark "1?10"  == ["1010","1110"]
  print $ replaceQuestionMark "1?1?0" == ["10100","10110","11100","11110"]
