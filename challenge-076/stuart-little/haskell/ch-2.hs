#!/usr/bin/env runghc

-- run <script> <path-to-dict>

import System.Environment (getArgs,)
import Data.List (isInfixOf,transpose,)
import Data.Tuple.Extra ((&&&),)
import Data.Universe.Helpers (diagonals,)
import Data.Char (toUpper,)

allDirections :: [[a]] -> [[a]]
allDirections mat = concat $ take 4 $ map ((uncurry (++)).(id &&& diagonals)) $ iterate (reverse.transpose) mat

main = do
  wrds <- getArgs >>= (readFile.head) >>= (return.words)
  let whereToLook = allDirections ["BIDEMIATSUCCORST","LDEGGIWQHODEEHDP","USEIRUBUTEASLAGU","NGNIZILAICOSCNUD","TGMIDSTSARAREIFG","SRENMDCHASIVEELI","SCSHAEUEBROADMTE","HWOVLPEDDLAIULSS","RYONLASFCSTAOGOT","IGUSSRRUGOVARYOC","NRGPATNANGILAMOO","EIHACEIVIRUSESED","SETSUDTTGARLICNH","HVRMXLWIUMSNSOTB","AEAOFILCHTODCAEU","ZSCDFECAAIIRLNRF","ARIIANYUTOOOUTPF","RSECISNABOSCNERA","DRSMPCUUNELTESIL"]
  mapM_ putStrLn $ filter ((\w -> any (isInfixOf w) whereToLook).(map toUpper)) $ filter ((>=5).length) wrds
