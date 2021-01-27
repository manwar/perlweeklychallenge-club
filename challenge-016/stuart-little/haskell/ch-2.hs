#!/usr/bin/env runghc

-- run <script> <bitcoin address>
 
import Control.Monad (liftM)
import Crypto.Hash.SHA256 (hash)
import Data.ByteString (ByteString)
import Data.Digits (digits,unDigits)
import Data.List ((\\),elemIndex)
import System.Environment (getArgs)
import qualified Data.ByteString as B

digs :: String
digs = ['1'..'9'] ++ (['A'..'Z']\\"IO") ++ (['a'..'z']\\"l")

dec58 :: String -> Integer
dec58 = maybe (error "Invalid chars") id .
           liftM (unDigits 58) .
           traverse ((liftM toInteger) . (flip elemIndex digs))

intToB :: Integer -> ByteString
intToB = B.pack . map fromInteger . digits 256

validCs :: ByteString -> Bool
validCs address =
  let (value, checksum) = B.splitAt 21 $ leftPad address
  in and $ B.zipWith (==) checksum $ hash $ hash $ value
  where
    leftPad bs = B.concat [B.replicate (25 - B.length bs) 0, bs]

valid :: String -> String
valid btc
  |B.length bs > 25 = error "Too long"
  |B.length bs < 4 = error "Too short"
  |not $ validCs bs = error "Checksum fail"
  |otherwise = "Valid" where
     bs = intToB $ dec58 btc

main = do
  btc <- getArgs >>= return . head
  putStrLn $ valid btc

-- ref: https://rosettacode.org/wiki/Bitcoin/address_validation#Haskell
