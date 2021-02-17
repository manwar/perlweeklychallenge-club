module Example exposing (..)

import Expect exposing (Expectation)
import Fun exposing (convert)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


suite : Test
suite =
    describe "Fun"
        [ test "convert 07:15" <|
            \_ ->
                let
                    got =
                        convert "07:15"
                in
                Expect.equal got "07:15am"
        , test "convert 05:15pm" <|
            \_ ->
                let
                    got =
                        convert "05:15 pm"
                in
                Expect.equal got "17:15"
        , test "convert 19:15" <|
            \_ ->
                let
                    got =
                        convert "19:15"
                in
                Expect.equal got "07:15pm"
        , test "convert 09:15" <|
            \_ ->
                let
                    got =
                        convert "09:15 am"
                in
                Expect.equal got "09:15"
        ]
