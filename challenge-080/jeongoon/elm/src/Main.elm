{- Tested with:
elm make src/Main.elm
# and access elm/index.html in a web browser(firefox in my case)
# which shows Task1 and Task2 altogether
-}

module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import String
import Tuple

-- Solutions ...
import Ch1
import Ch2

-- Main

main =
    Browser.sandbox {init = init, update = update, view = view }

-- Model

type alias Model =
    { numberListStringT1 : String
    , numberListT1 : List Int
    , smallestMissingPN : Maybe Int
    , numberListStringT2 : String
    , numberListT2 : List Int
    , candies : Maybe Int
    }

init : Model
init = Model "" [] Nothing "" [] Nothing

-- Update

type Task  = Task1 | Task2

type Msg
    = FindSmallestMissingPN String
    | CountCandies String

update : Msg -> Model -> Model
update msg model =
    case msg of
        FindSmallestMissingPN newListString ->
            let res = Ch1.findSmallestMissingPN newListString
            in { model
                   | numberListStringT1 = newListString
                   , numberListT1       = Tuple.first  res
                   , smallestMissingPN  = Tuple.second res }
        CountCandies newListString ->
            let res = Ch2.countCandies newListString
            in { model
                   | numberListStringT2 = newListString
                   , numberListT2       = Tuple.first  res
                   , candies            = Tuple.second res }

-- View

view : Model -> Html Msg
view model =
    div [ style "width" "90%" ]
        [ h1 [] [ text "Task1: Smallest Positive Number"]
        , viewInput "text" "Type a list of integers (negative one fine :-), sperated by space"
            model.numberListStringT1 FindSmallestMissingPN
        , displaySizeOfList "List Size: " model.numberListT1
        , displayAnswer Task1 "Smallest missing positive number: "
            model.numberListT1 model.smallestMissingPN
        , h1 [] [ text "Task2: Count Candies" ]
        , viewInput "text" "Type a list of rank(numbers), seprated by space"
            model.numberListStringT2 CountCandies
        , displaySizeOfList "Candy Members: " model.numberListT2
        , displayAnswer Task2 "Total candies in need: "
            model.numberListT2 model.candies
        ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  div [ style "background-color" "gray" ]
      [ input [ size 150, type_ t, placeholder p, value v, onInput toMsg ] [] ]

displaySizeOfList : String -> List Int -> Html msg
displaySizeOfList sizeOfString numList =
    case List.length numList of
        0 -> div [] [ text ( sizeOfString ++ "0" ) ]
        x -> div [] [ text ( sizeOfString ++ (String.fromInt x) ) ]

displayAnswer : Task -> String -> List Int -> Maybe Int -> Html msg
displayAnswer task entryString anyNumberList answer =
    case answer of
        Nothing ->
            if List.length anyNumberList == 0 then
                div [ style "color" "blue" ] [ text "List is empty" ]
            else
                case task of
                    Task1 ->
                        div [ style "color" "red" ]
                            [ text ( entryString ++
                                         "(not found but alternatively) " ++
                                         (String.fromInt(Ch1.alternativeSmallest
                                                             anyNumberList)) ) ]
                    _ ->
                        div [style "color" "red" ]
                            [ text "(List is not useful)" ]
        Just  x ->
            div [ style "color" "green" ] [ text ( entryString ++
                                                       String.fromInt(x) ) ]
