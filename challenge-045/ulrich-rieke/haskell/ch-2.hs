module Challenge045_2
  where
import System.Environment ( getProgName )
import System.IO

main :: IO ( )
main = do
  filename <- getProgName
  filelines <- fmap lines $ readFile filename
  mapM_ putStrLn filelines
