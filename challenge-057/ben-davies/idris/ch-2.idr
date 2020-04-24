module Main

%default total

-- Finds the longest unique prefix for the LHS in the RHS.
prefixFor : (x : String) -> (y : String) -> String
prefixFor x y = case head' $ dropWhile (`isPrefixOf` unpack y) (inits $ unpack x) of
                     Nothing => ""
                     Just cs => pack cs

-- Given a list of words, finds the unique prefixes for a word.
prefixesFor : (ws : List String) -> (w : String) -> List String
prefixesFor ws w = (`prefixFor` w) <$> ws

-- Given a list of words, finds the unique prefix for each word in the list.
prefixes : (ws : List String) -> List String
prefixes ws = foldr maxLength "" <$> transpose (prefixesFor ws <$> ws)
    where maxLength : String -> String -> String
          maxLength a b = if length b > length a then b else a

wordList : List String
wordList = ["alphabet", "book", "carpet", "cadmium", "cadeau", "alpine"]

main : IO ()
main = printLn $ prefixes wordList
