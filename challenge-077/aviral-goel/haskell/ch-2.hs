import Data.List (intersect)
import Data.Void (Void)
import Text.Megaparsec
import Text.Megaparsec.Char
import System.Environment (getArgs)
import Data.Maybe (fromMaybe)

data Matrix = Matrix { getRows :: Int
                     , getColumns :: Int
                     , getElements :: [[Char]]
                     }

type Position = (Int, Int)

isLonelyX :: [Position] -> Position -> Bool
isLonelyX xLocations (m, n) =
  null $ intersect xLocations adjacentLocations
  where adjacentLocations = [ (m - 1, n)
                            , (m + 1, n)
                            , (m, n - 1)
                            , (m, n + 1)
                            , (m - 1, n - 1)
                            , (m - 1, n + 1)
                            , (m + 1, n - 1)
                            , (m + 1, n + 1)
                            ]

wrap :: Matrix -> Matrix
wrap (Matrix {getRows = rows, getColumns = columns, getElements = elements}) =
  Matrix {getRows = rows + 2, getColumns = columns + 2, getElements = elements'}
  where newrow = [replicate columns '0']
        elements' = map (\row -> '0':row ++ ['0']) (newrow ++ elements ++ newrow)

-- returns positions of all lonely X
lonelyX :: Matrix -> [Position]
lonelyX matrix =
  filter (isLonelyX xLocations) xLocations
  where matrix' = wrap matrix
        elements' = getElements matrix'
        xLocations = concat [[(m, n) | (n, element) <- zip [0..] row, element == 'X'] | (m, row) <- zip [0..] elements']

type Parser = Parsec Void String

rowParser :: Parser [Char]
rowParser = space *> char '[' *> space *> many (alphaNumChar <* space) <* char ']'

matrixParser :: Parser [[Char]]
matrixParser = many rowParser

main :: IO ()
main = do
    input <- getArgs
    let input' = concat input
    let positions = do
          matrix <- parseMaybe matrixParser input'
          let positions' = lonelyX $ Matrix (length matrix) (length (head matrix)) matrix
          return positions'
    print $ length $ fromMaybe [] positions
