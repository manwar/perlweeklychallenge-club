module Ch1 exposing ( .. )

import String  as S
import Bitwise as B
import List    as L
import Maybe   as Mb

-- translated from ch-1.hs
-- but elm is different in some respect
errInvalidInteger = "Invalid Integer value"

filter32Bit : String -> Result String String
filter32Bit nstr  =
    case (S.toInt (S.trim nstr)) of
        Nothing -> Err errInvalidInteger
        Just  k -> let n  = S.left 1 nstr
                       ns = S.dropLeft 1 nstr
                       lim   = limitAbs Nothing k
                       limStr = S.fromInt lim
                       limStrWithSign = if n == "-" then "-" ++ limStr
                                        else limStr
                       nstrAbs = case n of
                                     "+" -> ns
                                     "-" -> ns
                                     _   -> nstr
                       filteredExplanation = ("32bit limit is " ++
                                                  limStrWithSign )
                   in case compare (S.length nstrAbs) (S.length limStr) of
                          LT -> Ok nstr
                          EQ -> if nstrAbs < limStr then Ok nstr
                                else Err filteredExplanation
                          GT -> Err filteredExplanation

limitAbs : Maybe Int -> Int -> Int
limitAbs maybeBit n =
    case maybeBit of
        Nothing -> limitAbs (Just 32) n
                   -- I don't know why but som function in elm
                   -- normally has opposite order  of arguments when compared to
                   -- other language??
        Just  b -> let lim = abs (B.shiftLeftBy (b - 1) 1)
                             -- note: abs is required otherwise overflow occurs.
                   in if n < 0 then lim else lim - 1

reverseIntStr : String -> Result String String
reverseIntStr istr  =
    if (S.isEmpty (S.trim istr)) then Err ""
    else
        case S.toInt istr of
            Nothing -> Err errInvalidInteger
            Just n  ->
                Ok (if n == 0 then "0"
                    else let i  = S.left 1 istr
                             is = S.dropLeft 1 istr in
                         remove_zeroes_ (case i of
                                             "+" ->        (S.reverse is)
                                             "-" -> "-" ++ (S.reverse is)
                                             _   ->        (S.reverse istr)))
remove_zeroes_ : String -> String
remove_zeroes_ nstr =
    if (S.length nstr) == 0 then "0"
    else let n =  S.left 1 nstr
             ns = S.dropLeft 1 nstr
         in if n == "0" then remove_zeroes_ (S.dropLeft 1 nstr)
         else nstr
