import Data.List (group)

largestSameDigNum :: String -> Int
largestSameDigNum = maximum
                  . map (read :: String -> Int)
                  . group

main :: IO ()
main = do
  print $ largestSameDigNum "6777133339" == 3333
  print $ largestSameDigNum "1200034"    == 4
  print $ largestSameDigNum "44221155"   == 55
  print $ largestSameDigNum "88888"      == 88888
  print $ largestSameDigNum "11122233"   == 222
