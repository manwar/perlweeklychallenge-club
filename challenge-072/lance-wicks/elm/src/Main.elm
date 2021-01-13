module Main exposing (..)

import Array exposing (map)
import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Regex
import String


main =
    Browser.sandbox { init = initModel, update = update, view = view }


type alias Model =
    { number : Int
    , factorialOfNumber : Int
    , trailingZeroes : Int
    }


initModel =
    { number = 10
    , factorialOfNumber = 0
    , trailingZeroes = 0
    }


type Msg
    = Increment
    | Decrement


update msg model =
    case msg of
        Increment ->
            { model | number = model.number + 1 }

        Decrement ->
            { model | number = model.number - 1 }


view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text ("Number:" ++ String.fromInt model.number) ]
        , div [] [ text ("Trailing zeroes of factorial:" ++ String.fromInt (calcFactorial model.number)) ]
        , div [] [ text ("Factorial of number:" ++ String.fromInt (trailingZeroes (calcFactorial model.number))) ]
        , button [ onClick Increment ] [ text "+" ]
        ]


calcFactorial : Int -> Int
calcFactorial n =
    List.product (List.range 1 n)


trailingZeroes : Int -> Int
trailingZeroes x =
    let
        a =
            List.head <|
                Regex.find zeroes <|
                    String.fromInt x
    in
    case a of
        Just foo ->
            String.length foo.match

        Nothing ->
            0


zeroes =
    Maybe.withDefault Regex.never (Regex.fromString "0+$")
