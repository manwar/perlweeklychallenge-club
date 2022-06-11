module Main where

import           Control.Monad      ((>=>))
import           Data.Char          (ord)
import           System.Environment (getArgs)
import           System.Exit        (exitFailure)

main :: IO ()
main = do
    testISBN <- getArgs >>= maybe (die usage) return . safeHead
    either die print $ calculateCheckDigit <$> parseISBN testISBN
  where usage = "Pass ISBN as first argument."

parseISBN :: String -> Either String [Int]
parseISBN =
        maybeToEither "Contains invalid ISBN characters." . mapM digitToInt
        .   filter (/= '-')
        >=> checkLength
  where
    checkLength x | length x == 12 = return x
                  | otherwise      = Left "Need 12 digits in ISBN."

calculateCheckDigit :: [Int] -> Int
calculateCheckDigit isbn12 =
    let weightedSums =  sum $ zipWith (*) isbn12 weights
    in (10 - weightedSums `mod` 10) `mod` 10
  where
    weights = [1, 3] ++ weights

digitToInt :: Char -> Maybe Int
digitToInt c =
    let digit = ord c - ord '0'
    in  if 0 <= digit && digit <= 9
            then return digit
            else Nothing

safeHead :: [a] -> Maybe a
safeHead []      = Nothing
safeHead (x : _) = Just x

maybeToEither :: a -> Maybe b -> Either a b
maybeToEither a = maybe (Left a) Right

die :: String -> IO a
die msg = putStrLn msg >> exitFailure
