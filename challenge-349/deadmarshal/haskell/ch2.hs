module Ch2 where

meetingPoint :: String -> Bool
meetingPoint s = x == 0 && y == 0
  where
    (x,y) = foldl move (0,0) s
    move (x,y) c = case c of
      'U' -> (x,y+1)
      'R' -> (x+1,y)
      'D' -> (x,y-1)
      'L' -> (x-1,y)
      _ -> (x,y)

main :: IO ()
main = do
  print $ meetingPoint "ULD"
  print $ meetingPoint "ULDR"
  print $ meetingPoint "UUURRRDDD"
  print $ meetingPoint "UURRRDDLLL"
  print $ meetingPoint "RRUULLDDRRUU"

