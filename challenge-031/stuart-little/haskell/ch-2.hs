#!/usr/bin/env runghc

-- run <script> <variable_name> <integer>

import System.Environment (getArgs,)

data NamedVar = NV { name :: String  
                   , value :: Int
                   } deriving (Show)   

main = do
  (nm,val) <- getArgs >>= return.(\(a:b:_) -> (a,(read b::Int)))
  let var :: NamedVar
      var = NV {name=nm, value=val}
  putStrLn $ "Your variable is named " ++ (show $ name var) ++ " and its value is " ++ (show $ value var) ++ "."
