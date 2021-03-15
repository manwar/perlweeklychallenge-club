#!/usr/bin/env runghc

-- run <script> <nr tokens; defaults to 12>

import Safe (headDef)
import System.Environment (getArgs)
import System.Random (randomRIO)

youPlay :: Int -> Int -> IO String
youPlay hp k
  |hp==0 = return "You lose!"
  |otherwise = do
     putStrLn $ "The heap contains " ++ (show hp) ++ " tokens."
     putStrLn $ "How many tokens are you removing? Please enter an integer between 1 and " ++ (show k) ++ " inclusive: "
     take <- getLine >>= return . (read::String->Int)
     compPlay (hp-take) k

compPlay :: Int -> Int -> IO String
compPlay hp k
  |hp==0 = return "You win!"
  |otherwise = do
     putStrLn $ "The heap contains " ++ (show hp) ++ " tokens."
     rnd <- randomRIO (1,k)
     let take = if (mod hp (k+1) /= 0) then (mod hp (k+1)) else rnd
     putStrLn $ "The computer removes " ++ (show take) ++ " items."
     youPlay (hp-take) k

main = do
  hp <- getArgs >>= return . (read::String->Int) . headDef "12"
  out <- youPlay hp 3
  putStrLn out
