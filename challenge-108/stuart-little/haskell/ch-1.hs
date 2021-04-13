#!/usr/bin/env runghc

-- run <script>
-- ref: https://stackoverflow.com/a/18563789/11064961

{-# LANGUAGE MagicHash, BangPatterns #-}

import GHC.Exts

data Ptr' a = Ptr' a

getIntAddr :: Int -> Int
getIntAddr x = let !y = Ptr' x in unsafeCoerce# y :: Int

x :: Int
x=5

main :: IO ()
main = do
  putStrLn $ "The variable x has value " ++ (show x) ++ " and address " ++ (show . getIntAddr $! x) ++ "."
