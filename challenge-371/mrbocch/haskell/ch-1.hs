import Data.Function
import Data.Char (ord, chr)

missingLetter :: String -> Char
missingLetter s = slidingWindow 2 s
                & filter (not . elem '?')
                & map (map ord)
                & map reverse
                & map (foldl1 (-))
                & concat . repeat
                & zip s
                & resolve
    where
        resolve :: [(Char, Int)] -> Char
        resolve ((c1, s1):(c2, s2):xs)
            | c1 == '?' = (ord c2) - s1 & chr
            | c2 == '?' = (ord c1) + s1 & chr
            | otherwise = resolve xs


slidingWindow :: Int -> [a] -> [[a]]
slidingWindow n xs
    | n == length xs = [take n xs]
    | otherwise      = (take n xs) : slidingWindow n (tail xs)

main :: IO ()
main = do
    print $ missingLetter "ac?gi" == 'e'
    print $ missingLetter "ad?jm" == 'g'
    print $ missingLetter "ae?mq" == 'i'
    print $ missingLetter "acf?k" == 'h'
    print $ missingLetter "beg?l" == 'j'
