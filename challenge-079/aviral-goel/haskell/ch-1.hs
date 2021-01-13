import System.Environment (getArgs)

setBitCount :: Int -> Int
setBitCount 0 = 0
setBitCount x = n + setBitCount x'
  where (x', n) = divMod x 2

allSetBits :: [Int] -> Int
allSetBits = sum . map setBitCount

main :: IO ()
main = do
  s <- fmap head getArgs
  let x = read s :: Int
  let bits = allSetBits [1..x] `mod` 1000000007
  putStrLn (show bits)
