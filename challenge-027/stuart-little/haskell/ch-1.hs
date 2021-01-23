#!/usr/bin/env runghc

{-
run <script> <8 space-separated coordinates>; e.g.

<script> a b c d p q r s will return the intersection between lines
(a,b), (c,d) and
(p,q), (r,s)
-}

import Data.List.Split (chunksOf,)
import Graphics.Gloss.Geometry.Line (intersectLineLine,)
import System.Environment (getArgs,)

main = do
  (p1:p2:q1:q2:_) <- getArgs >>= return . (map (\[x,y]->(x,y))) . (chunksOf 2) . (map (read::String->Float)) . (take 8)
  let inter = intersectLineLine p1 p2 q1 q2
  putStrLn $ case inter of
    Nothing -> "No intersection."
    Just x -> show x
