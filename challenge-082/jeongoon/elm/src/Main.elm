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

import String as S
import List   as L

-- Solutions ...
import Ch1 exposing (..)
import Ch2 exposing (..)

-- Main

main =
    Browser.sandbox { init = init, update = update, view = view }

-- Model

type alias Model =
    { ch1IntM    : Int
    , ch1IntN    : Int
    , ch1Result  : Result String (List Int)
    , ch2StringA : String
    , ch2StringB : String
    , ch2StringC : String
    , ch2Result  : Result String (List (List String))
    }

init : Model
init = Model 0 0 (Err "") "" "" "" (Err "")

-- Update

type Task = Task1 | Task2

type Msg = CommonFactorsM String
         | CommonFactorsN String
         | InterleavedStringFirst String
         | InterleavedStringSecond String
         | InterleavedStringInterleaved String

update : Msg -> Model -> Model
update msg m =
    case msg of  -- nv: new value
        CommonFactorsM nv ->
            case S.toInt nv of
                Nothing -> { m | ch1IntM = 0 }
                Just ni ->
                    let res = Ch1.getCommonFactors ni m.ch1IntN
                    in { m | ch1IntM = ni, ch1Result = res }
        CommonFactorsN nv ->
            case S.toInt nv of
                Nothing -> { m | ch1IntN = 0 }
                Just ni ->
                    let res = Ch1.getCommonFactors m.ch1IntM ni
                    in { m | ch1IntN = ni, ch1Result = res }
        InterleavedStringFirst nv ->
            let res = Ch2.checkInterleavedString nv m.ch2StringB m.ch2StringC
            in { m | ch2StringA = nv, ch2Result  = res }
        InterleavedStringSecond nv ->
            let res = Ch2.checkInterleavedString m.ch2StringA nv m.ch2StringC
            in { m | ch2StringB = nv , ch2Result = res }
        InterleavedStringInterleaved nv ->
            let res = Ch2.checkInterleavedString m.ch2StringA m.ch2StringB nv
            in { m | ch2StringC = nv , ch2Result = res }
-- View

view : Model -> Html Msg
view m =
    div [ style "padding" "20px", style "width" "90%" ]
        [ h1 [] [ text "Task1: Common Factors" ]
        , viewInputInt "text" "$M" m.ch1IntM CommonFactorsM
        , viewInputInt "text" "$N" m.ch1IntN CommonFactorsN
        , displayAnswerCh1 m.ch1Result
        , h1 [] [ text "Task2: Interleave String" ]
        , viewInput "text" "String A"
            m.ch2StringA InterleavedStringFirst
        , viewInput "text" "String B"
            m.ch2StringB InterleavedStringSecond
        , viewInput "text" "String C (maybe interleaved)"
            m.ch2StringC InterleavedStringInterleaved
        , displayAnswerCh2 m.ch2StringC m.ch2Result
        ]

viewInputInt : String -> String -> Int -> (String -> msg) -> Html msg
viewInputInt t p i toMsg =
    viewInput t p (if i < 0 then ""
                   else S.fromInt i ) toMsg

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    div [ style "display" "inline-block" ]
        [ input [ size 150, type_ t, placeholder p, value v, onInput toMsg ] []]

displayAnswerCh1 : Result String (List Int) -> Html msg
displayAnswerCh1 result =
    displayAnswer "Result"
        (case result of
             Ok ints ->
                 Ok ("(" ++ (S.join ","
                                 (L.map S.fromInt ints)) ++ ")")
             Err e   -> Err e)

displayAnswerCh2 : String -> Result String (List (List String)) -> Html msg
displayAnswerCh2 stringC result =
    displayAnswer "Result: "
        (case result of
             Ok listOfStringList ->
                 Ok ("1 (Interleaved) as `" ++ stringC ++ "' can be divided into\n"
                         ++ (S.join "\n"
                                 (L.map
                                      (\sl ->
                                           "[" ++ (S.join ", " sl) ++ "]" )
                                      listOfStringList )))
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
