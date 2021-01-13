module Ch1 exposing (pairNumberListAndMajor)
import String
import Tuple
import List exposing (map, head, tail)

pairNumberListAndMajor : String -> ( List Int, Maybe Int )
pairNumberListAndMajor newListString =
    let newNumberList = List.filterMap
                        String.toInt (String.split " " newListString)
        count k = List.length( List.filter (\y -> k == y) newNumberList )
        halfLen = List.length( newNumberList ) // 2 -- //-> integer division
        findMajor maybels  =
            case maybels of
                Nothing -> Nothing
                Just ls ->
                    case (List.head ls) of
                        Nothing -> Nothing
                        Just  m -> if (count m) > halfLen
                                   then Just m
                                   else findMajor (List.tail ls)
    in
        ( newNumberList, findMajor (Just newNumberList) )
