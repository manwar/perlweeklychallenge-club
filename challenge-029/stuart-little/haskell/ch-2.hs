#!/usr/bin/env runghc

{-
run <script>

ref:
http://book.realworldhaskell.org/read/interfacing-with-c-the-ffi.html
-}

{-# LANGUAGE ForeignFunctionInterface #-}

import Foreign
import Foreign.C.Types

foreign import ccall "math.h exp"
     c_exp :: CDouble -> CDouble

main = do
  mapM_ (print . c_exp) [1..10]
