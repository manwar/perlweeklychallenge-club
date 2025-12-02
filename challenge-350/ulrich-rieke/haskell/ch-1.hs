module Challenge350
   where
import Data.List.Split ( divvy )
import qualified Data.Set as S

solution :: String -> Int   
solution = length . filter ( (== 3 ) . length ) . map S.fromList . divvy 3 1

main :: IO ( )
main = do
   putStrLn "Enter a word!"
   line <- getLine
   print $ solution line
