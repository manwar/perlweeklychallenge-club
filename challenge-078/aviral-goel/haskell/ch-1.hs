import Data.Void (Void)
import Data.List (intercalate)
import Text.Megaparsec
import Text.Megaparsec.Char
import Text.Megaparsec.Char.Lexer (decimal)
import System.Environment (getArgs)
import Data.Maybe (fromMaybe)

leaders :: [Int] -> [Int]
leaders xs =
  select $ foldr largest [-1] $ tail xs
  where largest x (y:ys) = (max x y) : y : ys
        select ys = map fst $ filter (\(x, y) ->  x > y) (zip xs ys)

type Parser = Parsec Void String

parseArray :: Parser [Int]
parseArray = char '(' *> space *> sepBy decimal (char ',' <* space) <* char ')'

main :: IO ()
main = do
  input <- fmap concat getArgs
  let ys = do
        xs <- parseMaybe parseArray input
        return $ leaders xs
  let output = "(" ++ intercalate ", " (map show (fromMaybe [] ys)) ++ ")"
  putStrLn output
