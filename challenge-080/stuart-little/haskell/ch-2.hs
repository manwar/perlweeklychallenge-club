#!/usr/bin/env runghc

-- run as <script> <space-separated array entries>

import System.Environment   
import Data.List  

candy a = (length a) + (length $ filter ((/=) 0) $ zipWith (-) a $ tail a)

main = do  
    args <- getArgs
    print $ candy $ map (\y -> read y::Integer) args
