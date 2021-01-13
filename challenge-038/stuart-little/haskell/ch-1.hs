#!/usr/bin/env runghc

-- run <script> <string>

import Control.Monad (liftM,)
import System.Environment (getArgs,)
import Data.List.Split (splitPlaces,)
import Data.Maybe (fromMaybe,)
import Data.Time.Calendar (fromGregorianValid,showGregorian)

yearBase "1" = "20"
yearBase "2" = "19"

prettyDateValid str = fromMaybe "Invalid" $ liftM showGregorian $ fromGregorianValid y m d where
  (control:yy:mm:dd:_) = splitPlaces [1,2,2,2] str
  y = read ((yearBase control) ++ yy)::Integer 
  (m:d:_) = map (read::String->Int) [mm,dd]

main = do
  args <- getArgs
  putStrLn $ prettyDateValid $ args !! 0
