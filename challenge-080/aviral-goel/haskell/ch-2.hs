import Text.Megaparsec
import Data.Void (Void)
import Text.Megaparsec.Char
import Text.Megaparsec.Char.Lexer (decimal)
import System.Environment (getArgs)
import Data.Maybe (fromMaybe)


candyCount :: [Int] -> Int
candyCount xs = length xs + count' xs (tail xs) + count' (tail xs) xs
  where count' xs ys = sum $ map compare (zip xs ys)
        compare (x, y) = if x > y then 1 else 0

type Parser = Parsec Void String

parseArray :: Parser [Int]
parseArray = char '(' *> space *> sepBy decimal (char ',' <* space) <* char ')'

main :: IO ()
main = do
  input <- fmap concat getArgs
  let array = parseMaybe parseArray input
  let array' = fromMaybe [1..] array
  putStrLn $ show $ candyCount array'
