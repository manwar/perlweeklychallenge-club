module Challenge178
  where
import Data.Complex
import Data.Char ( digitToInt , intToDigit )
import Data.List ( (!!) , intersperse )

complexify :: Float -> Complex Float
complexify f = f :+ 0.0

basePowers :: [Complex Float]
basePowers = map (\i -> base ^ i ) [0 , 1 .. 8]
where
  base :: Complex Float
  base = 0.0 :+ 2

convertQuaterImagString :: String -> Complex Float
convertQuaterImagString s = sum $ map (\p -> fst p * ( basePowers !!
( snd p ))) $ zip ( map (complexify . fromIntegral . digitToInt ) reversed
) [0 .. 8]
where
  reversed :: String
  reversed = reverse s

findAllCombinations :: Int -> [[Int]]
findAllCombinations n = map (\li -> map ( floor . realPart ) li ) [[a , b ,
c , d , e] | a <- range , b <- range , c <- range, d <- range ,
e <- range , (floor $ realPart (a * (basePowers !!
8 ) + b *  ( basePowers !! 6 ) + c * ( basePowers !! 4 ) + d *
( basePowers !! 2 ) + e * ( basePowers !! 0 ))) == n]
where
  range :: [Complex Float]
  range = map ( complexify . fromIntegral ) [0..3]

intoQuaterImagString :: Int -> [String]
intoQuaterImagString n = map (\li -> map intToDigit $ dropWhile ( == 0 ) $
intersperse 0 li )  $ findAllCombinations n

main :: IO ( )
main = do
  putStrLn "What do you want to do?"
  putStrLn "convert an integer to a quater-imaginary?(y or n)"
  answer <- getLine
  if head answer == 'y'
  then do
      putStrLn "Enter the integer you want to convert!"
      number <- getLine
      mapM_ putStrLn $ intoQuaterImagString $ read number
  else do
      putStrLn "Enter the number string to the base 2i ( up to 8 digits )!"
      putStrLn "Only digits from 0 to 3 are allowed!"
      numberstring <- getLine
      let result = convertQuaterImagString numberstring
      putStrLn ( "(" ++ (show $ realPart result) ++ ")" ++ " + " ++
      "(" ++ ( show $ imagPart result ) ++ "i )")
