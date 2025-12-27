module Challenge353
   where

solution :: [String] -> Int
solution = maximum . map ( length . words )

enterLines :: IO [String]
enterLines = do
   line <- getLine
   if null line then return []
   else (line : ) <$> enterLines     

main :: IO ( )
main = do
   putStrLn "Enter some strings , enter <return> to end!"
   totalInput <- enterLines
   print $ solution totalInput
