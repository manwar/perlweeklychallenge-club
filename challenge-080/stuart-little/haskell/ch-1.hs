#!/usr/bin/env runghc

-- run as <script> <space-separated array entries>

import System.Environment   
import Data.List  

firstMisPos a = head [x | x <- [1..], notElem x a]

main = do  
    args <- getArgs
    print $ firstMisPos $ map (\y -> read y::Integer) args
