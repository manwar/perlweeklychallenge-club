import Data.Void (Void)
import Text.Megaparsec
import Text.Megaparsec.Char
import Text.Megaparsec.Char.Lexer (decimal)
import System.Environment (getArgs)
import Data.Maybe (fromMaybe)
import Data.List (find)

type Column = (Int, Int)

area :: (Maybe Column, Column, Maybe Column) -> Int
area (Nothing, _, _) = 0
area (_, _, Nothing) = 0
area (Just (l1, h1), (_, h2), Just (l3, h3)) = (min h1 h3 - h2) * (l3 - l1 - 1)

columns :: [Int] -> [Column]
columns xs = zip [1..] xs

unique :: [Column] -> [Column]
unique [] = []
unique [c] = [c]
unique (v:v':c) | snd v == snd v' = unique (v':c)
                | otherwise = v : unique (v':c)

walls :: ([Column], Column, [Column]) -> (Maybe Column, Column, Maybe Column)
walls (as, x, bs) = (find (greater x) as, x, find (greater x) bs)
  where greater y y' = snd y' > snd y

split :: [Column] -> [([Column], Column, [Column])]
split [] = []
split (z:zs) = reverse $ split' [] z zs []
  where split' as x [] ys = (as, x, []) : ys
        split' as x (b:bs) ys = split' (x:as) b bs ((as, x, (b:bs)) : ys)

trappedWater :: [Int] -> Int
trappedWater = sum . map area . map walls . split . unique . columns

type Parser = Parsec Void String

parseArray :: Parser [Int]
parseArray = char '(' *> space *> sepBy decimal (char ',' <* space) <* char ')'

main :: IO ()
main = do
  input <- fmap concat getArgs
  let n = do
        xs <- parseMaybe parseArray input
        return $ trappedWater xs
  putStrLn $ show $ fromMaybe 0 n

