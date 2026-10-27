module Challenge397
   where

solution :: [Int] -> Int
solution list = 
   let average = (fromIntegral $ sum list) / (fromIntegral $ length list)
       ceil = ceiling average
   in if fromIntegral ceil == average then head $ filter (\n -> and [n > 0 , 
     notElem n list ] ) [ceil + 1 , ceil + 2 ..] else head $ filter (\n ->
        n > 0 && ( notElem n list )) [ceil , ceil + 1 ..]

main :: IO ( )
main = do
   putStrLn "Enter some integers separated by blanks!"
   numberline <- getLine
   print $ solution ( map read $ words numberline :: [Int] )
