module Challenge365
   where
import Data.Char( ord , digitToInt )

convert :: String -> Int
convert str = read $ foldl1 ( ++ ) $ map (\c -> show (ord c - 96) ) str

digitSum :: Int -> Int
digitSum = sum . map digitToInt . show

solution :: String -> Int -> Int
solution str howoften =  fst $ until ((== 0 ) . snd ) step (convert str , howoften )
   where
      step :: ( Int , Int ) -> (Int , Int)
      step ( currentNum , stillToGo ) = ( digitSum currentNum, stillToGo - 1 )

main :: IO ( )
main = do
   putStrLn "Enter an English word with lowercase letters only!"
   word <- getLine
   putStrLn "Enter a number greater than 0!"
   numberline <- getLine
   print $ solution word ( read numberline :: Int ) 
