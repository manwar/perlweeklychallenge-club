#!/usr/bin/env runghc

-- run <script>

{-# LANGUAGE QuasiQuotes #-}
import Text.RawString.QQ

multi :: String
multi = [r|    ^^^^^
   ^     ^
  ^       ^
 ^         ^
 ^         ^
 ^         ^
 ^         ^
 ^         ^
  ^       ^
   ^     ^
    ^^^^^
      ^
      ^
      ^
    ^^^^^
      ^
      ^
|]

main :: IO ()
main = putStrLn multi
  
