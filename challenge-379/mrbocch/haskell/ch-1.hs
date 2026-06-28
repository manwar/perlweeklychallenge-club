rev :: [a] -> [a]
rev = foldl (flip (:)) []

main :: IO ()
main = do
    print $ rev ""                         == reverse ""
    print $ rev "reverse the given string" == reverse "reverse the given string"
    print $ rev "Perl is Awesome"          == reverse "Perl is Awesome"
    print $ rev "v1.0.0-Beta!"             == reverse "v1.0.0-Beta!"
    print $ rev "racecar"                  == reverse "racecar"
