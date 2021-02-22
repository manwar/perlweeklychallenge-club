#!/usr/bin/env runghc

-- run <script> <quoted block of text>

import Data.Char (toUpper)
import Data.List (intercalate,intersperse)
import Data.List.Extra (replace)
import System.Environment (getArgs)

dict :: [(Char,String)]
dict = map (\(c,s) ->
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

wToMorse :: String -> String
wToMorse = intercalate (replicate 3 '0') . map (maybe "" id) . map (flip lookup dict) . map toUpper

sToMorse :: String -> String
sToMorse = intercalate (replicate 7 '0') . map wToMorse . words

main = do
  txt <- getArgs >>= return.head
  putStrLn $ sToMorse txt
