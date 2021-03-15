#!/usr/bin/env runghc

-- run <script>

import qualified Data.Cache.LRU as C

main = do
  let l = C.insert 3 7 $ C.insert 2 5 $ C.insert 1 3 $ C.newLRU (Just 3)
  
  putStrLn "\nInitial cache:"
  print l
  
  putStrLn "\nSeeking item at pos. 2:"
  let (l',val) = C.lookup 2 l
  putStrLn $ "Value: " ++ (show val)
  putStrLn $ "Cache state: " ++ (show l')

  putStrLn "\nSeeking item at pos. 1:"
  let (l'',val) = C.lookup 1 l'
  putStrLn $ "Value: " ++ (show val)
  putStrLn $ "Cache state: " ++ (show l'')

  putStrLn "\nSeeking item at pos. 4:"
  let (l''',val) = C.lookup 4 l''
  putStrLn $ "Value: " ++ (show val)
  putStrLn $ "Cache state: " ++ (show l''')

  putStrLn "\nInserting new item 9 at pos 4:"
  let l4 = C.insert 4 9 l'''
  putStrLn $ "Cache state: " ++ (show l4)

