#!/usr/bin/env runghc

-- run <script> <path>

import System.Environment (getArgs)
import System.FilePath (normalise)
import Text.RegexPR (subRegexPR)

normDdots :: String -> String
normDdots pth = head $ dropWhile (\x -> norm1dd x /= x) $ iterate norm1dd pth where
  norm1dd = normalise . (subRegexPR "(?<=/)[^/.]+/+\\.\\." "")

stripTrail :: String -> String
stripTrail s = if l=='/' then init s else s where
  l = last s

main :: IO ()
main = getArgs >>= putStrLn . stripTrail . normDdots . normalise . head
