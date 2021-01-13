import Data.Void (Void)
import Data.List (intercalate)
import Text.Megaparsec
import Text.Megaparsec.Char
import Text.Megaparsec.Char.Lexer (decimal)
import System.Environment (getArgs)
import Data.Maybe (fromMaybe)

rotateLeft :: [Int] -> Int -> [Int]
rotateLeft (x:xs) n =
  rotateLeft' n (x:xs) []
  where rotateLeft' 0 xs ys = xs ++ reverse ys
        rotateLeft' n [] ys = error "invalid element index"
        rotateLeft' n (x:xs) ys = rotateLeft' (n - 1) xs (x:ys)

rotations :: [Int] -> [Int] -> [[Int]]
rotations xs indices = map (rotateLeft xs) indices

type Parser = Parsec Void String

parseArray :: Parser [Int]
parseArray = char '[' *> space *> sepBy decimal (char ',' <* space) <* char ']'

parseArrays :: Parser ([Int], [Int])
parseArrays = do
  xs <- parseArray
  ys <- parseArray
  return (xs, ys)


arrayToString :: String -> String -> String -> [Int] -> String
arrayToString left right sep xs = left ++ intercalate sep (map show xs) ++ right

main :: IO ()
main = do
  input <- fmap concat getArgs
  let zs = do
        (xs, ys) <- parseMaybe parseArrays input
        return $ rotations xs ys
  let output = intercalate "\n" $ map (arrayToString "[" "]"  ",") (fromMaybe [] zs)
  putStrLn output
