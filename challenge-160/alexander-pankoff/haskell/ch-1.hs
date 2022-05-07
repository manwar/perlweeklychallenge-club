module Main where

import Data.Char (toLower, toUpper)
import Data.Foldable (forM_)
import Data.List (intercalate)

main :: IO ()
main = do
  forM_ [One .. Nine] $ putStrLn . fourIsMagic

data Digit
  = One
  | Two
  | Three
  | Four
  | Five
  | Six
  | Seven
  | Eight
  | Nine
  deriving (Show, Eq, Ord, Enum)

toCardinal :: Digit -> String
toCardinal = lcFirst . show

fourIsMagic :: Digit -> String
fourIsMagic x = ucFirst $ intercalate ", " $ reverse $ go [] x
  where
    go acc Four = (toCardinal Four ++ " is magic.") : acc
    go acc x =
      let cardinal = toCardinal x
          next = toEnum (length cardinal - 1)
       in go ((cardinal ++ " is " ++ toCardinal next) : acc) next

lcFirst :: String -> String
lcFirst [] = []
lcFirst (x : xs) = toLower x : xs

ucFirst :: String -> String
ucFirst [] = []
ucFirst (x : xs) = toUpper x : xs
