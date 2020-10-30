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
    { ch1IntStr      : String
    , ch1ReversedStr : String
    , ch1Result      : Result String String
    , ch2MatString   : String
    , ch2Squares     : Result String (List Ch2.Square)
    }

init : Model
init = Model "" "" (Err "") "" (Err "")

-- Update

type Task = Task1 | Task2

type Msg = ReverseIntegerValueChanged String
         | FindSquareMatrixChanged    String

update : Msg -> Model -> Model
update msg m =
    case msg of  -- nv: new value
        ReverseIntegerValueChanged nv ->
            let resReversed = Ch1.reverseIntStr nv in
            case resReversed of
                Err e -> { m | ch1IntStr = nv
                         , ch1ReversedStr = ""
                         , ch1Result = (Err e) }
                Ok  reversed ->
                    { m | ch1IntStr = nv
                    , ch1ReversedStr = reversed
                    , ch1Result = Ch1.filter32Bit reversed }
        FindSquareMatrixChanged nv ->
            -- ref: https://package.elm-lang.org/packages/elm/core/latest/Basics#(|%3E)
            --      https://package.elm-lang.org/packages/elm/core/latest/Result#andThen
            { m | ch2MatString = nv
                  , ch2Squares =
                  ( nv
                  |> Ch2.pointsAtRowsFromString
                  |> R.andThen Ch2.getHorizLines
                  |> R.andThen Ch2.findSquares ) }

-- View

view : Model -> Html Msg
view m =
    div [ style "padding" "20px", style "width" "90%" ]
        [ h1 [] [ text "Task1: Reverse Integer" ]
        , viewInput "text" "Input" m.ch1IntStr ReverseIntegerValueChanged
        , displayAnswerCh1 m
        , h1 [] [ text "Task2: Find Squares" ]
        , viewInputTextArea "Input a matrix data"
            m.ch2MatString FindSquareMatrixChanged
        , displayAnswerCh2 m.ch2Squares
        ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    div [ style "display" "inline-block" ]
        [ input [ size 150, type_ t, placeholder p, value v, onInput toMsg ] []]

viewInputTextArea : String -> String -> (String -> msg) -> Html msg
viewInputTextArea p v toMsg =
    div [ style "display" "inline-block" ]
        [ textarea [ rows 5, cols 150
                   , placeholder p, value v, onInput toMsg ] [] ]

displayAnswerCh1 : Model -> Html msg
displayAnswerCh1 m =
    displayAnswer "Result"
        (case m.ch1Result of
             Ok filteredReversed ->
                 Ok filteredReversed
             Err e ->
                 if e == "" then
                     Ok ""
                 else
                     Err (m.ch1IntStr ++ " was reversed as\n"
                              ++ m.ch1ReversedStr
                              ++ "\nHowever filtred because\n" ++ e))

displayAnswerCh2 : Result String (List Ch2.Square) -> Html msg
displayAnswerCh2 result =
    displayAnswer "Result: "
        (case result of
             Ok squaresList ->
                 Ok (S.concat
                     (("Found " ++ (S.fromInt (L.length squaresList))
                           ++ " squares.\n")
                     :: (L.indexedMap
                             (\idx sq ->
                                  let sz = (S.fromInt (sq.hline.end
                                                      - sq.hline.start)) in
                                  (S.fromInt (idx + 1))
                                  ++ ": (" ++ sz ++ " X " ++ sz ++ ")"
                                  ++ " from (r:" ++ (S.fromInt sq.hline.row)
                                  ++ ", c:" ++ (S.fromInt sq.hline.start)
                                  ++ ") to (r:" ++ (S.fromInt sq.alsoAtRow)
                                  ++ ", c: " ++ (S.fromInt sq.hline.end)
                                  ++ ")\n")
                             squaresList)))
             Err e -> Err e)

viewReadOnlyTextArea : String -> String -> Html msg
viewReadOnlyTextArea color str =
    textarea [ readonly True, style "color" color
             , rows 15, cols 150, value str ] []

displayAnswer : String -> Result String String -> Html msg
displayAnswer entryString result =
    case result of
        Ok msg  -> div []
                   [ viewReadOnlyTextArea "green" msg ]
        Err e ->
            if e == ""
            then div []
                [ viewReadOnlyTextArea "blue"
                      (entryString ++ "please input all the entries") ]
            else div []
                [ viewReadOnlyTextArea "red" e ]
