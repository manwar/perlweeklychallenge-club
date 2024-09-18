module Challenge287_2
   where
import Data.Char
import Text.ParserCombinators.ReadP
import Control.Applicative ((<|>))
import Data.List ( init ) 

sign :: ReadP Char
sign = do
   char '-' <|> char '+' 

numbers :: ReadP String
numbers = do
   many1 $ satisfy isDigit

integer :: ReadP String
integer = do
   si <- option ' ' sign
   nums <- numbers
   if si /= ' ' then pure ([si] ++ nums) else pure nums

expo :: ReadP String
expo = do
   c <- char 'e' <|> char 'E' 
   number <- integer
   pure ([c] ++ number) 

decimalfirst :: ReadP String
decimalfirst = do
   si <- option ' ' sign
   num <- numbers
   char '.'
   if si /= ' ' then pure ([si] ++ num ++ "." ) else pure (num ++ ".")

decimalsecond :: ReadP String
decimalsecond = do
   si <- option ' ' sign
   num <- numbers
   char '.'
   numgroup <- numbers
   if si /= ' ' then pure ([si] ++ num ++ "." ++ numgroup ) else pure( num ++ 
	 "." ++ numgroup ) 

decimalthird :: ReadP String
decimalthird = do
   si <- option ' ' sign
   char '.' 
   num <- numbers
   if si /= ' ' then pure ([si] ++ "." ++ num ) else pure ("." ++ num)

validNum :: ReadP String
validNum = do
   numgroup <- ( integer  >> option " " expo ) <|> ( decimalsecond >>
	 option " " expo ) <|> (decimalthird >> option " " expo ) <|> 
         (decimalfirst >> option " " expo )
   if last numgroup == ' ' then pure ( init numgroup ) else pure numgroup 

main :: IO ( )
main = do 
   putStrLn "Enter a string!"
   string <- getLine
   let p = readP_to_S validNum string
   if null p then print "false" else if ( null $ snd $ last p ) then print "true"
    else print "false"
