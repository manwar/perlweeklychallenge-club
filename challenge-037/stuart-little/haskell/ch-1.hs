#!/usr/bin/env runghc

-- run <script> <year or nothing to default to current>

import Data.Maybe (isJust,fromJust)
import Data.Time.Calendar (DayOfWeek( Saturday,Sunday ),dayOfWeek,fromGregorianValid,toGregorian)
import Data.Time.Clock (getCurrentTime,utctDay)
import Safe (headMay)
import System.Environment (getArgs)

currY :: IO Integer
currY = getCurrentTime >>= return . (\(y,m,d)-> y) . toGregorian . utctDay

nrWeekDays :: Integer -> Int -> Int
nrWeekDays y m = length $ filter (flip notElem [Saturday,Sunday]) $ map (dayOfWeek.fromJust) $ filter isJust $ map (fromGregorianValid y m) [1..31]

main = do
  curr <- currY
  y <- getArgs >>= return . maybe curr (read::String->Integer) . headMay
  putStrLn $ "Year: " ++ (show y)
  mapM_ putStrLn $ map (\(m,nr) -> (show m) ++ ": " ++ (show nr) ++ " days") $ zip [1..12] $ map (nrWeekDays y) [1..12]
