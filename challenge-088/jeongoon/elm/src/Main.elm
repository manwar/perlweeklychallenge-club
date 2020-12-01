{- Tested with:
elm make src/Main.elm
# and access elm/index.html in a web browser(firefox in my case)
# which shows Task1 and Task2 altogether
# or ...
elm reactor
# and access localhost:8000 (again in a web browser)
# and click  `Main.elm'
-}

module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import String as S
import List   as L
import Result as R

-- Solutions ...
import Ch1 exposing (..)
import Ch2 exposing (..)

-- Main

main =
    Browser.sandbox { init = init, update = update, view = view }

-- Model
type alias Model =
    { ch1IntListStr : String
    , ch1Result     : Result String (List Int)
    , ch2MatrixStr  : String
    , ch2Result     : Result String (List String)
    }

init : Model
init = Model "" (Err "") "" (Err "")

-- Update

type Task = Task1
type Msg = ArrayProductValueChanged String
         | SpiralMatrixValueChanged String

getPositiveIntegerListFromString : String -> Result String (List Int)
getPositiveIntegerListFromString str =
    let trimed_str = S.trim str
        sls  = (S.split " " trimed_str)
        ints = L.filterMap S.toInt sls
    in if S.length trimed_str == 0 then
           Err "" -- indicate initial state
       else if (L.length sls) == (L.length ints) then Ok ints
            else Err "Some element doesn't look like a POSITIVE integer"

update : Msg -> Model -> Model
update msg m =
    case msg of
        ArrayProductValueChanged nv ->
            let res = (getPositiveIntegerListFromString nv
                      |> R.andThen Ch1.arrayOfProduct)
            in { m | ch1IntListStr = nv
               , ch1Result = res }
        SpiralMatrixValueChanged nv ->
            let res = Ch2.getSpiralArrayFromString nv
            in { m | ch2MatrixStr = nv
               , ch2Result = res }

-- View

view : Model -> Html Msg
view m =
    div [ style "padding" "20px", style "width" "90%" ]
        [ h1 [] [ text "Task1: Array Product" ]
        , viewInput "text" "Positive Integers" m.ch1IntListStr
              ArrayProductValueChanged
        , displayAnswerCh1 m.ch1Result
        , h1 [] [ text "Task2: Spiral Matrix" ]
        , viewInputTextArea "Please Input a matrix data.\nex)\n[a b c]\n[d e f]\n[g h i]"
            m.ch2MatrixStr SpiralMatrixValueChanged
        , displayAnswerCh2 m.ch2Result
        ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    div [ style "dispay" "inline-block" ]
        [ input [ size 150, type_ t, placeholder p, value v, onInput toMsg ] []]

viewInputTextArea : String -> String -> (String -> msg) -> Html msg
viewInputTextArea p v toMsg =
    div [ style "display" "inline-block" ]
        [ textarea [ rows 5, cols 150
                   , placeholder p, value v, onInput toMsg ] [] ]

displayAnswerCh1 : Result String (List Int) -> Html msg
displayAnswerCh1 result =
    displayAnswer "Result"
        (case result of
             Ok ints -> Ok ("(" ++ (S.join ","
                                        (L.map S.fromInt ints)) ++")")
             Err e   -> Err e)

displayAnswerCh2 : Result String (List String) -> Html msg
displayAnswerCh2 result =
    displayAnswer "Result"
        (case result of
             Ok words -> Ok ("(" ++ (S.join "," words) ++ ")")
             Err    e -> Err e)


displayAnswer : String -> Result String String -> Html msg
displayAnswer entryString result =
    case result of
        Ok msg  -> div []
                   [ viewReadOnlyTextArea "green" msg ]
        Err e ->
            if e == ""
            then div []
                [ viewReadOnlyTextArea "blue"
                      (entryString ++ ": please input all the entries") ]
            else div []
                [ viewReadOnlyTextArea "red" e ]

viewReadOnlyTextArea : String -> String -> Html msg
viewReadOnlyTextArea color str =
    textarea [ readonly True, style "color" color
             , rows 15, cols 150, value str ] []
