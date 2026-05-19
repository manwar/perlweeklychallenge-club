reArrangeSpaces :: String -> String
reArrangeSpaces s
    | wordCount s == 1 = (head . words $ s) ++ replicate (spacesCount s) ' '
    | otherwise        = disperse (replicate spacesBetween ' ') (words s) ++ replicate spacesEnd ' '
    where
        spacesBetween :: Int
        spacesBetween = quot (spacesCount s) (gapCount s)

        spacesEnd :: Int
        spacesEnd = mod (spacesCount s) (gapCount s)

        disperse :: String -> [String] -> String
        disperse _ [s]          = s
        disperse between (s:sx) = s ++ between ++ disperse between sx

        gapCount :: String -> Int
        gapCount = flip (-) 1 . wordCount

        spacesCount :: String -> Int
        spacesCount = length . filter (==' ')

        wordCount :: String -> Int
        wordCount = length . words

main :: IO ()
main = do
    print $ reArrangeSpaces "  challenge  "               == "challenge    "
    print $ reArrangeSpaces "coding  is  fun"             == "coding  is  fun"
    print $ reArrangeSpaces "a b c  d"                    == "a b c d "
    print $ reArrangeSpaces "  team      pwc  "           == "team          pwc"
    print $ reArrangeSpaces "   the  weekly  challenge  " == "the    weekly    challenge "
