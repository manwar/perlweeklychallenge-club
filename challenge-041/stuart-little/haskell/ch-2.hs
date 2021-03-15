#!/usr/bin/env runghc

-- run <script>

import Data.Function (fix,)

main = do
  mapM_ print $ take 20 $ fix (scanl (\x y -> x + y + 1) 1 . ((-1):))
