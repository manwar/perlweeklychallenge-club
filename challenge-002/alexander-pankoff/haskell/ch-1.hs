module Main where

main :: IO ()
main = interact removeLeadingZeros

removeLeadingZeros :: String -> String
removeLeadingZeros = dropWhile (== '0')
