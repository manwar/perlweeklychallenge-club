module Challenge145_2
  where
import Data.List ( nub , inits , (!!) )

findList :: Int -> String -> [String]
findList pos str = [[ str !! pos ]] ++ [ head $ filter isPalindrome $ reverse
$ inits $ drop pos str ]

isPalindrome :: String -> Bool
isPalindrome str = str == reverse str

solution :: String -> [String]
solution str = nub $ concat $ map (\i -> findList i str )
[0 .. length str - 1]
