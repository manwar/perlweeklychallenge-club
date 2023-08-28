module Ch2 where

seniorCitizens :: [String] -> Int
seniorCitizens xs =
  length $ filter (>= 60)
  $ map (\s -> read s :: Int)
  $ map (\s -> take 2 $ drop (length s-4) s) xs

main :: IO ()
main = do
  print $ seniorCitizens ["7868190130M7522",
                          "5303914400F9211",
                          "9273338290F4010"]
  print $ seniorCitizens ["1313579440F2036",
                          "2921522980M5644"]
  
