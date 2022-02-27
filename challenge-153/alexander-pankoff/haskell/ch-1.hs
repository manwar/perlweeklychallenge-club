import           Data.Function                  ( (&) )

main :: IO ()
main = drop 1 leftFactorials & take 10 & print

leftFactorials :: [Integer]
leftFactorials = 0 : zipWith (+) leftFactorials facs

facs :: [Integer]
facs = 1 : zipWith (*) facs [1 ..]