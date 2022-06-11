module Main where

import Control.Monad (liftM2)

main :: IO ()
main = print $ primePalindromes [1 .. 1000]

primePalindromes :: [Int] -> [Int]
primePalindromes = filter (liftM2 (&&) isPalindrome isPrime)

isPrime :: Int -> Bool
isPrime n = n > 1 && null [x | x <- [2 .. (isqrt n)], n `mod` x == 0]

isPalindrome :: Int -> Bool
isPalindrome = liftM2 (==) show (reverse . show)

isqrt :: Int -> Int
isqrt = floor . sqrt . fromIntegral