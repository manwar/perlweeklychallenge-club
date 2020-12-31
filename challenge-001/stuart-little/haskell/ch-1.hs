#!/usr/bin/env runghc

-- run as <script>

s="Perl Weekly Challenge"

main = do  
  putStrLn $ "Number of 'e's: " ++ (show $ length $ filter ((==) 'e') s)
  putStrLn (let tr 'e' = 'E'; tr c = c in map tr s)
