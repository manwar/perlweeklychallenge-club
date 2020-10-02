module Ch2 exposing (countCandies)
import String

countCandies : String -> ( List Int, Maybe Int )
countCandies newListString =
    let newNumberList = List.sort
                        ( List.filterMap
                              String.toInt (String.split " " newListString ) )
        len = List.length newNumberList
        leftGroup = if len > 0 then List.take (len-1) newNumberList else []
        rightGroup = case List.tail newNumberList of
                         Nothing -> []
                         Just ls -> ls
        candies = if len <= 1 then len
                  else len + ( List.sum
                                   ( List.map2 (\l r ->
                                                    if l /= r then 1 else 0 )
                                         leftGroup rightGroup ) )
    in ( newNumberList, Just candies )
