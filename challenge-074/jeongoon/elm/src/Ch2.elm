module Ch2 exposing (getFNR)
import String exposing (join, split)
import Dict
import List exposing (head, tail)
import Maybe exposing (withDefault)

getFNR : String -> Maybe String
getFNR newString =
    let chrs   = split "" newString
        counts x dic = case (Dict.get x dic) of
                         Nothing -> 0
                         Just  n -> n
        doFind dic rfnr cs =
            case (head cs) of
                Nothing ->
                    if List.length rfnr == 0 then Nothing
                    else Just (join "" (List.reverse rfnr))
                Just  k ->
                    case (counts k dic) of
                             0 -> doFind (Dict.insert k 1 dic) (k :: rfnr)
                                      (withDefault [] (tail cs))
                             m -> doFind (Dict.insert k (m+1) dic)
                                      ((findPrevious
                                            (Dict.insert k (m+1) dic) rfnr)
                                                :: rfnr)
                                      (withDefault [] (tail cs))
        findPrevious dic nrs =
            case (head nrs) of
                Nothing -> "#"
                Just  y ->
                    case (Dict.get y dic) of
                        Nothing -> y
                        Just  u -> if u == 1 then y
                                   else findPrevious dic
                                       (withDefault [] (tail nrs))

    in
        doFind Dict.empty [] chrs
