reverseWord word = [word !! i | i <- [length word - 1, length word - 2 .. 0]]
main = putStrLn (reverseWord("hello"))
