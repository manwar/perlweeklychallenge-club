{-# LANGUAGE OverloadedStrings #-}

module Challenge364_2
   where
import qualified Data.Text.Lazy as L

solution :: L.Text -> L.Text
solution myInput =
   let first = L.replace ( "()" ) (  "o" ) myInput
       second = L.replace( "(al)") (  "al" ) first
   in second    

main :: IO ( )
main = do
   putStrLn $  L.unpack $ solution ( "G()(al)" )
   putStrLn $  L.unpack $ solution ( "G()()()()(al)" )
   putStrLn $  L.unpack $ solution ( "(al)G(al)()()" )
   putStrLn $  L.unpack $ solution ( "()G()G" ) 
   putStrLn $  L.unpack $ solution $ "(al)(al)G()()"
