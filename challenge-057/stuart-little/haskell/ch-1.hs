#!/usr/bin/env runghc

-- run as <script> and enter a number of levels

import Data.Tree (Tree(Node), foldTree, drawTree)
import Data.List (intercalate)

invert t@(Node a xs) = (Node a (reverse $ map invert xs))

pp t = drawTree $ fmap show t

fromLevel start n
  |n==1 = (Node start [])
  |otherwise = (Node start [(fromLevel (2*start) (n-1)),(fromLevel (2*start+1) (n-1))])

main = do
  level <- getLine
  let tree = fromLevel 1 (read level::Int)
  putStrLn ("Initial tree:\n" ++ (pp tree) ++ (replicate 40 '-'))
  putStrLn ("Inverted tree:\n" ++ (pp $ invert tree) ++ (replicate 40 '-'))
