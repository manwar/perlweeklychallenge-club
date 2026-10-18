module Challenge395
   where
import Data.List.Split( splitOn )

parseComplex :: String -> (Int , Int)
parseComplex str = 
   let [realPart , imagPart] = splitOn "+" str
       image = if head imagPart == '(' then take ( length imagPart - 3 ) 
                $ drop 1 imagPart else take ( length imagPart - 1 ) 
                  imagPart
   in ( read realPart , read image )

complexMul :: (Int , Int) -> (Int , Int) -> (Int , Int)
complexMul ( a , b ) ( c , d ) = (a * c - b * d , b * c + a * d)

complexToString :: (Int , Int) -> String
complexToString ( a , b ) = if b >= 0 then show a ++ "+" ++ show b ++ "i"
 else show a ++ "+" ++ "(" ++ show b ++ ")i"

main :: IO ( )
main = do
   putStrLn "Enter two complex numbers as strings!"
   numbers <- getLine
   let nums = words numbers
       firstpair = parseComplex $ head nums
       secondpair = parseComplex $ last nums
   print $ complexToString $ complexMul firstpair secondpair    
