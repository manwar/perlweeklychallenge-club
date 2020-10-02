module Ch1 exposing ( findSmallestMissingPN
                    , alternativeSmallest )
import String

findSmallestMissingPN : String -> ( List Int, Maybe Int )
findSmallestMissingPN newListString =
    let newNumberList = List.sort
                        ( List.filterMap
                              String.toInt (String.split " " newListString ) )
        tallest = List.maximum newNumberList
        missing = case tallest of
                      Nothing -> []
                      Just tl ->
                          List.filterMap
                              (\x -> if List.member x newNumberList then Nothing
                                     else Just x)
                              (List.range 1 tl)
        smallestMissing = List.head missing -- can be Just x | Nothing
    in
        ( newNumberList, smallestMissing )

-- when their is no missing smallest among the postive integers
alternativeSmallest : List Int -> Int
alternativeSmallest ls =
    case List.maximum (List.filter (\x -> x > 0) ls) of
        Nothing -> 1
        Just tallest -> tallest + 1
