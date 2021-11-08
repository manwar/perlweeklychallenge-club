#!/usr/bin/env runghc

-- run <script> <bit position>

import Data.Bits (xor)
import System.Environment (getArgs)

swpBit :: Int -> Int -> Int
swpBit n b = xor n $ 2^(b-1)

main :: IO ()
main = getArgs >>= putStrLn.show.(uncurry swpBit).(\xs-> (head xs, head.tail $ xs)).map (read::String->Int).take 2
