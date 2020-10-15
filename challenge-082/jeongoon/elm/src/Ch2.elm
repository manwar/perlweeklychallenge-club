module Ch2 exposing ( checkInterleavedString
                    , allPossiblePartitions
                    , WhichPart )

import String as S
import List   as L
import Maybe  as Mb

type WhichPart = Odd | Even

checkInterleavedString : String -> String -> String ->
                         Result String (List (List String))
checkInterleavedString sa sb sc =
    if L.all (\x -> S.length x == 0 ) [sa, sb, sc]
    then Err "" -- probably initial state or equivalent to.
    else if L.any(\x -> S.length x == 0) [sa, sb, sc]
         then Err "Please input all the strings !!!"
         else
             let splitRules = allPossiblePartitions sa sb sc in
             if L.length splitRules > 0 then
                 Ok (L.map (\r ->
                                case interleavePartitions sc r of
                                    (a, b, scls) -> scls ) splitRules)
             else
                 Err "Not interleaved"

allPossiblePartitions : String -> String -> String -> (List (List Int))
allPossiblePartitions sa sb sc =
    if ( (S.length sa) + (S.length sb) /= S.length sc ) then
        []
    else
        let taretSum = S.length sc
            partls   =
                sps 1 taretSum
                    (\ints ->
                         if ( L.length ints ) <= 1 then
                             True -- skip as if okay, we will sieve later
                         else
                             case checkPartiallyInterleaved sa sb (sc, ints) of
                                 Ok _  -> True
                                 Err _ -> False
                    )
                [] [] in
        case partls of
            Nothing -> []
            Just ll -> L.filter (\ls -> L.length ls > 1
                                     && (L.sum ls) == taretSum
                                -- filter because  I checked them partially
                                ) ll

-- find possible summation (permutations with repeatation and filtering)
sps : Int -> Int -> -- sps : some possible sum
       (List Int -> Bool) -> -- validator
       List Int -> (List (List Int)) ->
       Maybe (List (List Int))
{- there are two terms are used
   next case:   [[ a case ], [ next case ], ... [ next .. ] ]
   lower case:  [[ a case :: (with) a lower case ],
                 [ a case :: (with) another lower case ], .. ],
                (and maybe) [ next case ] ]
-}

sps cn origSum isValid parts siblings = -- cn: current number
    if origSum == 0 then Just [] -- edge case for sure (but not Nothing)
    else
        let restSum    = (origSum  - cn)
            testParts  = (parts  ++ [cn])
            moreParts  = {-same as-}testParts
            nextNumber = cn + 1
            lowerCases = sps 1 restSum
                         isValid moreParts [] in
        if isValid testParts then
            if cn == origSum then
                -- reach the max: no more next cases
                -- concat with the cases in same level
                Just (siblings ++ [[cn]])
            else -- note: maybe have next cases
                 -- push current cases into siblings and continue to
                 -- next cases
                let currentCases =
                        (Mb.map (\ls -> L.map (\l -> cn :: l) ls)
                             lowerCases) in
                case currentCases of
                    Nothing ->
                        -- lower cases has problem so ignore
                        -- current one, keep going for next
                        sps nextNumber origSum
                            isValid parts siblings
                    Just cases ->
                        sps nextNumber origSum
                            isValid parts (siblings ++ cases)
        else
            -- in this task, we stop here because
            -- if smaller pieces cannot make a interleave string,
            -- the bigger won't either
            if L.length siblings > 0 then
                Just siblings
            else
                Nothing

checkPartiallyInterleaved : String -> String -> (String, List Int)
                 -> Result String (List String)
checkPartiallyInterleaved sa sb (sc, splitRules) =
    case L.length splitRules of
        0 -> Err "No split rule given"
        1 -> Err "Number of split rules are must be greater than 1"
        _ -> case interleavePartitions sc splitRules of
                 (a, b, scls) ->
                     -- we are comparing partially here
                     -- a: "XX" b: "YY" c: "XYXY" with [1,1,1] must be okay
                     -- because "XYX" -> "XX", "Y"
                     -- and startWith and `==' will check its validity
                     if ( (S.startsWith a sa && S.startsWith b sb)
                        -- or vice versa
                        ||(S.startsWith b sa && S.startsWith a sb) )
                     then
                         Ok scls
                     else Err "Not interleaved"

interleavePartitions : String -> List Int -> (String, String, List String)
interleavePartitions sc splitRules =
    it_part__ [""] [""] [] (S.split "" sc) splitRules Odd

it_part__ : List String -> List String -> List String -> List String ->
            List Int -> WhichPart
       -> (String, String, List String)
it_part__ os es ls chrs rules whichPart =
    case L.head rules of
        Nothing -> ( (S.concat os), (S.concat es), ls )
        Just  n ->
            let rs_   = L.drop 1 rules
                cs    = L.take n chrs
                parts = S.concat cs
                chrs_ = L.drop n chrs in
            case whichPart of
                Odd  -> it_part__ (os ++ cs) es (ls ++ [parts]) chrs_ rs_ Even
                Even -> it_part__ os (es ++ cs) (ls ++ [parts]) chrs_ rs_ Odd
