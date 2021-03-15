module Challenge096
  where
import qualified Data.Text as T

solution :: String -> String
solution str = unwords $ reverse $ words strippedString
where
  strippedString :: String
  strippedString = T.unpack $ T.dropWhileEnd( == ' ' ) $ T.pack
    $ dropWhile ( == ' ' ) str
