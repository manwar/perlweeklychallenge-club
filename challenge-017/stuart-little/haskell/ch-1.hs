#!/usr/bin/env runghc

-- run <script> <the two arguments to the Ackermann fn>

import System.Environment (getArgs,)

ack :: Integer -> Integer -> Integer
ack m n
  |m < 0 || n < 0 = error "invalid input"
  |m==0 =n+1
  |m==1 =n+2
  |m==2 =2*n+3
  |m==3 =2^(n+3)-3
  |m==4 && n==0 = 13
  |m==4 =2^(prev)-3
  |n==0 = ack (m-1) 1 
  |otherwise = ack (m-1) (ack m (n-1)) where
     prev = (ack 4 (n-1))+3

main = do
  (m:n:_) <- getArgs >>= return.(map (read::String->Integer))
  print $ ack m n
