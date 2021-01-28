#!/usr/bin/env runghc

-- run <script> <binary string>

import Data.Char (toLower)
import Data.List (intercalate,intersperse)
import Data.List.Extra (replace)
import Data.List.Split (split,startsWith)
import Data.List.Utils (join)
import Data.Maybe (catMaybes)
import Data.Tuple (swap)
import System.Environment (getArgs)

dict :: [(String,Char)]
dict = map swap $
       map (\(c,s) ->
              (c, replace "." "1" .
                replace "-" "111" .
                intersperse '0' $ s))
       [('A', ".-")
       ,('B', "-...")
       ,('C', "-.-.")
       ,('D', "-..")
       ,('E', ".")
       ,('F', "..-.")
       ,('G', "--.")
       ,('H', "....")
       ,('I', "..")
       ,('J', ".---")
       ,('K', "-.-")
       ,('L', ".-..")
       ,('M', "--")
       ,('N', "-.")
       ,('O', "---")
       ,('P', ".--.")
       ,('Q', "--.-")
       ,('R', ".-.")
       ,('S', "...")
       ,('T', "-")
       ,('U', "..-")
       ,('V', "...-")
       ,('W', ".--")
       ,('X', "-..-")
       ,('Y', "-.--")
       ,('Z', "--..")
       ,('0', "-----")
       ,('1', ".----")
       ,('2', "..---")
       ,('3', "...--")
       ,('4', "....-")
       ,('5', ".....")
       ,('6', "-....")
       ,('7', "--...")
       ,('8', "---..")
       ,('9', "----.")
       ,('@', ".--.-.")       
       ,('=', "-...-")
       ,('?', "..--..")
       ,('/', "-..-.")
       ,(',', "--..--")
       ,('.', ".-.-.-")
       ,(':', "---...")
       ,('\'', ".----.")
       ,('-', "-....-")
       ,('(', "-.--.")
       ,(')', "-.--.-")]

splitOn0 :: Int -> String -> [String]
splitOn0 n = map (dropWhile ('0'==)) .
             split (startsWith (replicate n '0')) 

wFromMorse :: String -> String
wFromMorse = catMaybes .
             map (flip lookup dict) .
             splitOn0 3

sFromMorse :: String -> String
sFromMorse = join " " .
             map wFromMorse .
             splitOn0 7

main = do
  bin <- getArgs >>= return.head
  putStrLn $ sFromMorse bin
