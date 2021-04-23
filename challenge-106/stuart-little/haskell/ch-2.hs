#!/usr/bin/env runghc

-- run <script> <numerator> <denominator>

import System.Environment (getArgs)

maxExp :: Int -> Int -> Int
maxExp p n
  |mod n p /= 0 =0
  |otherwise = succ $ maxExp p $ div n p

ordExp :: Int -> Int -> Int
ordExp n p = fst $ head $ dropWhile (\x -> mod ((snd x)-1) p /= 0) $ zip [1..] $ iterate (\x -> mod (x*n) p) (mod n p)

when10copr :: Int -> Int -> (Int,String)
when10copr num den = (intg, (replicate (digs - (length $ show fract)) '0') ++ (show fract)) where
  intg = div num den
  digs = ordExp 10 den
  fract = div ((mod num den) * (10^digs-1)) den

fractPart :: Int -> Int -> String
fractPart num den = nonRep ++ rep where
  exp2 = maxExp 2 den
  exp5 = maxExp 5 den
  newNum = if (exp2 >= exp5) then (5^(exp2-exp5) * num) else (2^(exp5-exp2) * num)
  copr = when10copr newNum $ div den (2^exp2 * 5^exp5)
  nonRep = if ((fst copr) + (max exp2 exp5) > 0) then (replicate ((max exp2 exp5) - (length $ show $ fst copr)) '0') ++ (show $ fst copr) else ""
  rep = if (snd copr /= "0") then ("(" ++ snd copr ++ ")") else ""

fractTot :: Int -> Int -> String
fractTot num den = (show $ div num den) ++ "." ++ fractPart (mod num den) den

main = do
  (num:den:_) <- getArgs >>= return . map (read::String -> Int)
  putStrLn $ fractTot num den
