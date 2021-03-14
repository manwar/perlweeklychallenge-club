module Zodiac_test exposing (..)

import Array
import Browser exposing (element)
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Html exposing (footer)
import Test exposing (..)
import Zodiac exposing (..)


sign_from_year_test =
    describe "Zodiac sign_from_year"
        [ test "1967 -> Fire Goat" <|
            \_ ->
                let
                    sign =
                        Zodiac.sign_from_year 1967
                in
                Expect.equal sign "Fire Goat"
        , test "2017 -> Fire Rooster" <|
            \_ ->
                let
                    sign =
                        Zodiac.sign_from_year 2017
                in
                Expect.equal sign "Fire Rooster"
        , test "1938 -> Earth Tiger" <|
            \_ ->
                let
                    sign =
                        Zodiac.sign_from_year 1938
                in
                Expect.equal sign "Earth Tiger"
        , test "1973 -> Water Ox" <|
            \_ ->
                let
                    sign =
                        Zodiac.sign_from_year 1973
                in
                Expect.equal sign "Water Ox"
        ]


table_index_test =
    describe "Zodiac table_index"
        [ test "1967 -> 44" <|
            \_ ->
                let
                    index =
                        Zodiac.table_index 1967
                in
                Expect.equal index 44
        , test "2017 -> 34" <|
            \_ ->
                let
                    index =
                        Zodiac.table_index 2017
                in
                Expect.equal index 34
        , test "1973" <|
            \_ ->
                let
                    index =
                        Zodiac.table_index 1973
                in
                Expect.equal index 50
        ]


table_test =
    describe "Zodiac table"
        [ test "60 rows" <|
            \_ ->
                let
                    ztable =
                        Zodiac.table
                in
                Expect.equal (Array.length ztable) 60
        , test "row 44 -> Fire Goat" <|
            \_ ->
                let
                    ztable =
                        Zodiac.table

                    element =
                        case Array.get 44 ztable of
                            Just foo ->
                                foo

                            Nothing ->
                                "Error!"
                in
                Expect.equal element "Fire Goat"
        , test "row 34 -> Fire Rooster" <|
            \_ ->
                let
                    ztable =
                        Zodiac.table

                    element =
                        case Array.get 34 ztable of
                            Just foo ->
                                foo

                            Nothing ->
                                "Error!"
                in
                Expect.equal element "Fire Rooster"
        ]
