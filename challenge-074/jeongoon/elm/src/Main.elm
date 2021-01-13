{- Tested with:
elm make src/Main.elm
# and access elm/index.html in a web browser(firefox in my case)
# which shows Task1 and Task2 altogether: couldn't find the better way
-}

module Main exposing (..)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import String
import List exposing (map, head, tail)

import Ch1
import Ch2

-- MAIN

main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL

type alias Model =
  { numberListString : String
  , numberList : List Int
  , majorNumber : Maybe Int
  , charListString : String
  , fnrString : Maybe String
  }

init : Model
init =
  Model "" [] Nothing "" Nothing

-- UPDATE

type Msg
  = FindMajor String
  | GetFNR String

update : Msg -> Model -> Model
update msg model =

  case msg of
    FindMajor newListString ->
        let result = Ch1.pairNumberListAndMajor newListString
        in { model
               | numberListString = newListString,
                 numberList  = Tuple.first  result,
                 majorNumber = Tuple.second result }
    GetFNR newString ->
        { model
            | charListString = newString,
              fnrString      = if String.length newString == 0 then Nothing
                               else Ch2.getFNR newString }


-- VIEW

view : Model -> Html Msg
view model =
  div [ style "width" "90%" ]
      [ h1 [] [ text "Task1: Majority Element" ]
      , viewInput "text" "Type List of numbers, separated by space"
          model.numberListString FindMajor
      , displaySizeOfList model
      , displayMajor model
      , h1 [] [ text "Task2: FNR" ]
      , viewInput "text" "Type a string consists of characters"
          model.charListString GetFNR
      , displayFNR model
      ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  div [ style "background-color" "gray" ]
      [ input [ size 150, type_ t, placeholder p, value v, onInput toMsg ] [] ]

displaySizeOfList : Model -> Html msg
displaySizeOfList model =
    case (List.length model.numberList) of
        0 -> div [] [ text "Size: 0" ]
        x -> div [] [ text ( "Size: " ++ (String.fromInt x) ) ]

displayMajor : Model -> Html msg
displayMajor model =
    case model.majorNumber of
        Nothing ->
            if List.length model.numberList == 0 then
                div [ style "color" "blue" ] [ text "List is empty" ]
            else
                div [ style "color" "red" ] [ text "Major Not Found: -1" ]
        Just  x ->
            div [ style "color" "green" ] [ text ( "Major Number: " ++
                                                       String.fromInt(x) ) ]

displayFNR model =
    case model.fnrString of
        Nothing ->
            div [ style "color" "red" ] [ text "No String given" ]
        Just  s ->
            div [ style "color" "green" ] [ text s ]
