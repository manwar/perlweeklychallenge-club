{- Tested with:
elm make src/Main.elm
# and access elm/index.html in a web browser(firefox in my case)
-}

module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import String as S
import List   as L

-- Solutions ...
import Ch2 exposing (..)

-- Main

main =
    Browser.sandbox { init = init, update = update, view = view }

-- Model

type alias Model =
    { ch2StringA : String
    , ch2StringB : String
    , ch2StringC : String
    , ch2Result  : Result String (List (List String))
    }

init : Model
init = Model "" "" "" (Err "")

-- Update

type Task = Task1 | Task2

type Msg = {-CommonFactors String | -}
         InterleavedStringFirst String
         | InterleavedStringSecond String
         | InterleavedStringInterleaved String

update : Msg -> Model -> Model
update msg m =
    case msg of
        InterleavedStringFirst nv -> -- new value
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
        [ h1 [] [ text "Task2: Interleave String" ]
        , viewInput "text" "String A"
            m.ch2StringA InterleavedStringFirst
        , viewInput "text" "String B"
            m.ch2StringB InterleavedStringSecond
        , viewInput "text" "String C (maybe interleaved)"
            m.ch2StringC InterleavedStringInterleaved
        , displayAnswerCh2 m.ch2StringC m.ch2Result
        ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    div [ style "display" "inline-block" ]
        [ input [ size 150, type_ t, placeholder p, value v, onInput toMsg ] []]

displayAnswerCh2 : String -> Result String (List (List String)) -> Html msg
displayAnswerCh2 stringC result =
    displayAnswer "Result: "
        (case result of
             Ok listOfStringList ->
                 Ok ("Interleaved as `" ++ stringC ++ "' can be divided into\n"
                         ++ (S.join " or "
                                 (L.map
                                      (\sl ->
                                           "[" ++ (S.join ", " sl) ++ "]" )
                                      listOfStringList )))
             Err e -> Err e)

displayAnswer : String -> Result String String -> Html msg
displayAnswer entryString result =
    case result of
        Ok str  -> div [ style "color" "green" ]
                 [ text (entryString ++ str) ]
        Err e ->
            if e == ""
            then div [ style "color" "blue" ]
                [ text (entryString ++ "please input all the entries") ]
            else div [ style "color" "red" ] [ text e ]
