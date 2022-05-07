module Main where

import Control.Monad (zipWithM)
import Data.List (elemIndex)

main :: IO ()
main = do
  print $ toBase35 10
  print $ toBase35 36
  print $ fromBase35 "A"
  print $ fromBase35 "11"
  print $ fromBase35 "10"

base35Alphabet :: [Char]
base35Alphabet = ['0' .. '9'] ++ ['A' .. 'Y']

toBase35 :: Int -> String
toBase35 x = go "" x
  where
    go acc 0 = acc
    go acc x = go (base35Alphabet !! (x `mod` 35) : acc) (x `div` 35)

fromBase35 :: [Char] -> Maybe Int
fromBase35 =
  fmap sum
    . zipWithM (\i c -> (*) (35 ^ i) <$> base35DigitToInt c) [0 ..]
    . reverse

base35DigitToInt :: Char -> Maybe Int
base35DigitToInt c = elemIndex c base35Alphabet
