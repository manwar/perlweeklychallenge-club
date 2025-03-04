import Data.Char
import Data.Bits

upperLower :: String -> String
upperLower = map (chr . xor 0x20 . ord)
