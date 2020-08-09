import System.Environment
import System.Exit
import Data.Char
import Control.Monad

{- Tested with:
ghc ch-1.hs
./ch-1 <Min> <Max>
-}
{- it was slow without compiling -}

wikiStroboDigits :: [Int];
wikiStroboDigits =  [ 0, 1, 6, 8, 9 ];
symmetricDigits ::  [Int];
symmetricDigits = [ 0, 1, 8 ];

lengthOfInt :: (Integral a, Integral b) => a -> b -> b
lengthOfInt x acc
  | x' `mod` (10 ^n') == (toInteger x) = acc
  | otherwise  = lengthOfInt x $! (acc+1)
  where
    x' = toInteger x
    n' = toInteger acc

getOppStroboDigits :: (Integral a) => [a] -> [a]
getOppStroboDigits xs = [ case id x of { (6) -> 9; (9) -> 6; _ -> x } | x <- reverse xs ]

generateStroboLeft :: (Integral a) => a -> a -> [[Int]] -> [[Int]]
generateStroboLeft halfLen clen acc -- clen initial value must be 1
  | halfLen == 0     = map (\x -> [x]) $ tail symmetricDigits -- XXX: totLen = 1
  | halfLen < 1     = [[]]
  | halfLen == 1     = [ [x] | x <- tail wikiStroboDigits ]
  | halfLen >= clen =
      generateStroboLeft halfLen (clen+1) [ foldr (:) [stb] l | l <- acc
                                                             , stb <- stroboLeft ]
  | otherwise    = acc
  where stroboLeft = if clen == 1  then tail wikiStroboDigits else wikiStroboDigits

stroboNumbersWith :: (Eq a, Integral a) => a -> [[Int]] -> [Int]
stroboNumbersWith totLen leftOnlyAcc =
  let left = generateStroboLeft halfLen 1 leftOnlyAcc
  in
    -- special case
    if totLen == 1 then map concatInt left
    else
      if hasMiddle then
        map concatInt [ foldr (:) (sym : (getOppStroboDigits l)) l | l <- left
                                                 , sym <- symmetricDigits ]
      else map concatInt [ foldr (:) (getOppStroboDigits l) l | l <- left ]
  where
    hasMiddle = totLen `mod` 2 == 1
    halfLen   = totLen `div` 2

concatInt :: [Int] -> Int
concatInt = foldl (\x y -> x*10+y) 0

filterRange :: Int -> Int -> [Int] -> [Int]
filterRange a b ls = filter (\x -> a <= x && x <= b ) ls

stroboNumbersWithRange :: Int -> Int -> Int -> Int -> Int -> [Int] -> [Int]
stroboNumbersWithRange a b minLen maxLen len acc
  | ( minLen /= minlen || maxLen /= maxlen ) || minLen > len =
    stroboNumbersWithRange a b minlen maxlen minlen [] -- initializing
  | len > maxLen = acc
  | len == minLen || len == maxLen =
      let acc' = filterRange a b $ stroboNumbersWith len [[]] -- not [] but [[]]
      in stroboNumbersWithRange a b minLen maxLen (len+1) (acc ++ acc')
  | otherwise =
      let acc' = stroboNumbersWith len [[]]
      in stroboNumbersWithRange a b minLen maxLen (len+1) (acc ++ acc')
  where
    minlen = (lengthOfInt a 1)
    maxlen = (lengthOfInt b 1)

main :: IO()
main = do
  args <- getArgs

  if length args /= 2 then
    die $ "[ERR] Wrnong Number of Args: " ++ (show (length args)) ++ "must be == 2"
    else
    return ()

  let a = read ( args !! 0 ) :: Int
      b = read ( args !! 1 ) :: Int
      numbers = stroboNumbersWithRange a b 0 0 0 []

  mapM_ (\x -> print x) numbers
