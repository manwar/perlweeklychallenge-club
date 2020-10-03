import Text.Megaparsec
import Data.Void (Void)
import Text.Megaparsec.Char
import Text.Megaparsec.Char.Lexer (signed, lexeme, decimal)
import System.Environment (getArgs)
import Data.Maybe (fromMaybe)
import Data.List ((\\))


smallestPositiveInteger :: [Int] -> Int
smallestPositiveInteger xs = head ([1..] \\ xs)

type Parser = Parsec Void String

parseArray :: Parser [Int]
parseArray = char '(' *> space *> sepBy (signed space (lexeme space decimal)) (char ',' <* space) <* char ')'

main :: IO ()
main = do
  input <- fmap concat getArgs
  let array = parseMaybe parseArray input
  let array' = fromMaybe [1..] array
  putStrLn $ show $ smallestPositiveInteger array'
