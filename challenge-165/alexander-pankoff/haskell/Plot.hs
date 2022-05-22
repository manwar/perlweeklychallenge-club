{-# LANGUAGE DeriveFunctor #-}

module Plot
  ( Plot,
    Line (..),
    Point (..),
    emptyPlot,
    addLine,
    parsePlot,
    plotLines,
    plotPoints,
    ToXML (..),
  )
where

import Data.Char (ord)

class ToXML a where
  toXML :: a -> String

data Plot = MkPlot
  { plotLines :: [Line],
    plotPoints :: [Point]
  }
  deriving (Show, Eq)

instance Semigroup Plot where
  a <> b =
    MkPlot
      { plotLines = plotLines a <> plotLines b,
        plotPoints = plotPoints a <> plotPoints b
      }

instance Monoid Plot where
  mempty = MkPlot [] []
  mappend = (<>)

instance ToXML Plot where
  toXML (MkPlot lines points) =
    let xmlLines = map toXML lines
        xmlPoints = map toXML points
     in unlines $
          [ "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>",
            "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.0//EN\" \"http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd\">",
            "<svg height=\"300\" width=\"400\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:svg=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\">",
            "<g id=\"lines\" stroke=\"#369\" stroke-width=\"4\">"
          ]
            ++ xmlLines
            ++ [ "</g>",
                 "<g fill=\"#f73\" id=\"points\">"
               ]
            ++ xmlPoints
            ++ [ "</g>",
                 "</svg>"
               ]

emptyPlot :: Plot
emptyPlot = MkPlot [] []

addLine :: Line -> Plot -> Plot
addLine l p = p {plotLines = l : plotLines p}

data Point = Point
  { x :: Double,
    y :: Double
  }
  deriving (Show, Eq)

instance ToXML Point where
  toXML (Point x y) = "<circle cx=\"" ++ show x ++ "\" cy=\"" ++ show y ++ "\" r=\"3\" />"

data Line = Line
  { start :: Point,
    end :: Point
  }
  deriving (Show, Eq)

instance ToXML Line where
  toXML (Line (Point x1 y1) (Point x2 y2)) =
    concat
      [ "<line x1=\"",
        show x1,
        "\" x2=\"",
        show x2,
        "\" y1=\"",
        show y1,
        "\" y2=\"",
        show y2,
        "\" />"
      ]

-- Parsing

newtype Parser a = Parser {runParser :: String -> Either ParseError (String, a)} deriving (Functor)

executeParser :: Parser a -> String -> Either ParseError a
executeParser p = fmap snd . runParser p

instance Applicative Parser where
  pure x = Parser $ \s -> return (s, x)
  ab <*> a = Parser $ \s -> do
    (s', ab') <- runParser ab s
    (s'', a') <- runParser a s'
    return (s'', ab' a')

instance Monad Parser where
  return = pure
  pa >>= apb = Parser $ \s -> do
    runParser pa s >>= uncurry (flip (runParser . apb))

data ParseError = InvalidInput
  deriving (Show, Eq)

(<|>) :: Parser a -> Parser a -> Parser a
a <|> b = Parser $ \s ->
  either (const $ runParser b s) return $ runParser a s

eof :: Parser ()
eof = Parser $ \s -> if null s then return (s, ()) else Left InvalidInput

-- Parsing

parsePlot :: [String] -> Either ParseError Plot
parsePlot =
  foldl
    ( \acc cur -> do
        p <- executeParser parseInputLine cur
        (<> p) <$> acc
    )
    (Right emptyPlot)

parseInputLine :: Parser Plot
parseInputLine =
  ( (lineParser >>= \l -> return $ emptyPlot {plotLines = [l]})
      <|> (pointParser >>= \p -> return $ emptyPlot {plotPoints = [p]})
  )
    <* eof

lineParser :: Parser Line
lineParser = Line <$> (pointParser <* commaParser) <*> pointParser

pointParser :: Parser Point
pointParser = Point <$> (fromIntegral <$> (intParser <* commaParser)) <*> (fromIntegral <$> intParser)

intParser :: Parser Integer
intParser = Parser $ \s ->
  if null s
    then Left InvalidInput
    else go 0 s
  where
    go acc "" = return ("", acc)
    go acc s@(x : xs) =
      maybe
        (return (s, acc))
        (\n -> go (acc * 10 + fromIntegral n) xs)
        $ digitToInt x

-- see challenge 162 ch-1.hs
digitToInt :: Char -> Maybe Int
digitToInt c =
  let digit = ord c - ord '0'
   in if 0 <= digit && digit <= 9
        then return digit
        else Nothing

commaParser :: Parser ()
commaParser = Parser $ \s ->
  if not (null s) && head s == ','
    then return (tail s, ())
    else Left InvalidInput