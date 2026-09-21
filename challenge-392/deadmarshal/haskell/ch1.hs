module Ch1 where

isPalindrome :: String -> Bool
isPalindrome p = p == reverse p

shortestPalindrome :: String -> String 
shortestPalindrome s =
  reverse rest ++ s 
  where 
    n = length s
    rest = head [drop k s | k <- [n,n-1..0],
                  isPalindrome $ take k s]

main :: IO ()
main = mapM_ (putStrLn . shortestPalindrome)
  [ "pinnipeds",
    "abcd",
    "bananas",
    "dissident",
    "cailliachs"
  ]
  
