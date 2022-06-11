module Challenge157
  where
import Text.Printf
import Data.List.Split ( splitOn )

findPythagoreanMeans :: [Int] -> [Double]
findPythagoreanMeans list = [(fromIntegral $ sum list) / fromIntegral l ,
(fromIntegral $ product list) ** ( recip $ fromIntegral l ) , (fromIntegral l) / ( sum $
map ( recip . fromIntegral) list)]
where
  l :: Int
  l = length list

convertToString :: [Double] -> String
convertToString means = foldl1 (\s t -> s ++ ", " ++ t ) $ zipWith( (++) )
["AM = " , "GM = " , "HM = "] ( map (\d -> printf "%.1f" d)  means )

main :: IO ( )
main = do
  putStrLn "Enter a line of integers, separated by a blank!"
  line <- getLine
  let numbers = map read $ splitOn " " line
      means  = findPythagoreanMeans numbers
  putStrLn $ convertToString means
