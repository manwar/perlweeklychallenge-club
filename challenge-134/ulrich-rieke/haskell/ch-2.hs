
{-# LANGUAGE OverloadedStrings #-}

module Challenge134_2
  where
import Control.Applicative
import qualified Data.Text as T
import qualified Data.Set as S
import Data.List ( sort , intercalate )
import Data.List.Split ( splitOn )

findFirstColWidth :: Int -> Int
findFirstColWidth n = ( length $ show n ) + 1

findMaxColWidth :: Int -> Int -> Int
findMaxColWidth n m = (length $ show ( n * m )) + 1

printTopLine :: Int -> Int -> T.Text
printTopLine m n = foldl1 T.append ([T.justifyLeft wid ' ' "x"  ,
  "|" ] ++ numberfield )
where
  wid :: Int
  wid = findFirstColWidth m
  numWid :: Int
  numWid = findMaxColWidth n m
  numberfield :: [T.Text]
  numberfield = map (\i -> T.justifyRight numWid ' ' ( T.pack $ show i) )
  [1 .. n]

printHyphenLine :: Int -> Int -> T.Text
printHyphenLine m n = foldl1 T.append [T.pack $ take wid $ cycle "-" ,
"+" , T.pack $ take ( n * maxWid ) $ cycle "-" ]
where
  wid :: Int
  wid = findFirstColWidth m
  maxWid :: Int
  maxWid = findMaxColWidth m n

printNumberLine :: Int -> Int -> Int -> T.Text
printNumberLine m n i = foldl1 T.append ( [firstCol , "|"]
      ++ numbers )
where
  wid :: Int
  wid = findFirstColWidth m
  maxWid :: Int
  maxWid = findMaxColWidth m n
  firstCol :: T.Text
  firstCol = T.justifyLeft wid ' ' (T.pack $ show i)
  numbers :: [T.Text]
  numbers = map (\d -> T.justifyRight maxWid ' ' ( T.pack $ show d ))
  ( (*) <$> [i] <*> [1 .. n] )

findTerms :: Int -> Int -> [Int]
findTerms m n = sort $ S.toList $ S.fromList ( (*) <$> [1 .. m] <*> [1 .. n] )

main :: IO ( )
main = do
  putStrLn "Enter 2 positive integers!"
  line <- getLine
  let nums = fmap read $ splitOn " " line
      m = head nums
      n = last nums
      distTerms = findTerms m n
      numberlines = map (\i -> printNumberLine m n i ) [1 .. m]
  putStrLn $ T.unpack $ printTopLine m n
  putStrLn $ T.unpack $ printHyphenLine m n
  mapM_ putStrLn $ fmap T.unpack numberlines
  putStrLn " "
  putStrLn ("Distinct Terms: " ++ ( intercalate "," $ fmap show distTerms ))
  putStrLn ("Count: " ++ (show $ length distTerms) )
