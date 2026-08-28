module Challenge388_2
   where
import Data.List ( permutations )
import qualified Data.Set as S

solution :: Int -> Int
solution n =
   let numbers = [1 , 2 ..n]
       permus = permutations numbers
       combis = map (\subli -> zip numbers subli ) permus
   in S.size $ S.fromList $ filter (\li -> all (\p -> fst p /= snd p ) li ) combis

main :: IO ( )
main = do
   putStrLn "Enter a positive integer!" 
   numberline <- getLine
   print $ solution ( read numberline :: Int )
