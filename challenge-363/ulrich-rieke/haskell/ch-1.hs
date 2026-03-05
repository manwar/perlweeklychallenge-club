module Challenge363
   where
import Data.List ( partition , (!!) )
import Data.Maybe ( fromJust )

conversions = zip numbers strings
   where
      numbers :: [Int]
      numbers = [0 , 1 ..20] 
      strings :: [String]
      strings = ["zero" , "one" , "two" , "three" , "four" , "five" , "six" , "seven" , 
                 "eight" , "nine" , "ten" , "eleven" , "twelve" , "thirteen" , 
                 "fourteen" , "fifteen" , "sixteen" , "seventeen" , "eighteen" , 
                 "nineteen" , "twenty"]

solution :: String -> Bool
solution sentence =
   let allWords = words sentence
       (foundVowels , foundConsonants) = partition ( flip elem vowels ) $ allWords !! 0 
   in ( (fromJust $ lookup ( length foundVowels ) conversions ) == allWords !! 2 ) && 
    ( fromJust $ lookup ( length foundConsonants ) conversions ) == allWords !! 5

vowels :: String
vowels = "AEIOUaeiou"

main :: IO ( )
main = do
   print $ solution "aa - two vowels and zero consonants"
   print $ solution "iv - one vowel and one consonant"
   print $ solution  "hello - three vowels and two consonants"
   print $ solution "aeiou - five vowels and zero consonants"
   print $ solution "aei - three vowels and zero consonants"
