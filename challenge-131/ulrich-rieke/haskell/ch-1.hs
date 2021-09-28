module Challenge131
  where
import System.Random ( getStdRandom , randomR )
import Data.List ( nub , sort )
import Data.List.Split ( chunksOf , splitOn )

convert :: [ Int ] -> String
convert list = "[" ++ (concat $ map (\i -> " " ++ show i ++ " ") list)
++ "]"

main :: IO ( )
main = do
  putStrLn "Enter a list of numbers, separated by spaces!"
  input <- getLine
  let numbers = sort $ nub $ map read $ splitOn " " input
  chunksize <- getStdRandom ( randomR ( 1 , length numbers - 1 ) )
  sublists <- return $ chunksOf chunksize numbers
  putChar '['
  putStr $ foldl1 ( ++ ) $ fmap convert sublists
  putStrLn " ]"
