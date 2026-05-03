import Data.Function
import Data.Char (ord, chr)

missingLetter :: String -> Char
missingLetter s = slidingWindow 2 s
                & filter (not . elem '?')
                & map (map ord)
                & map reverse
                & map (foldl1 (-))
                & take 2
                & (\steps -> if needsToRotate s then reverse steps else steps)
                & concat . repeat
                & zip s
                & resolve
    where
        resolve :: [(Char, Int)] -> Char
        resolve ((c1, s1):(c2, s2):xs)
            | c1 == '?' = (ord c2) - s1 & chr
            | c2 == '?' = (ord c1) + s1 & chr
            | otherwise = resolve ((c2,s2):xs) -- why does (_,_):[] not get caught?

        needsToRotate xs = needsToRotate' xs 1
            where
                needsToRotate' (x:xss) n
                    | x == '?'  = n `mod` 2 /= 0 && length xs /= n
                    | otherwise = needsToRotate' xss (n+1)

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
    print $ missingLetter "?cfhk" == 'a'
    print $ missingLetter "beg?l" == 'j'
    print $ missingLetter "?egjl" == 'b'
    print $ missingLetter "begj?" == 'l'
    print $ missingLetter "aceg?" == 'i'
