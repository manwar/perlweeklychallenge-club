module Zodiac exposing (..)

import Array


table_index : Int -> Int
table_index year =
    let
        step1 =
            year - 3

        step2 =
            step1 // 60

        step3 =
            step1 - (60 * step2)
    in
    step3


sign_from_year : Int -> String
sign_from_year year =
    let
        zodiac_table =
            table

        index =
            table_index year
    in
    case Array.get index zodiac_table of
        Just sign ->
            sign

        Nothing ->
            "ERROR: year->" ++ String.fromInt year ++ " index->" ++ String.fromInt index


table =
    let
        zodiac =
            [ "" -- Left blank intentionally
            , "Wood Rat"
            , "Wood Ox"
            , "Fire Tiger"
            , "Fire Rabbit"
            , "Earth Dragon"
            , "Earth Snake"
            , "Metal Horse"
            , "Metal Goat"
            , "Water Monkey"
            , "Water Rooster"
            , "Wood Dog"
            , "Wood Pig"
            , "Fire Rat"
            , "Fire Ox"
            , "Earth Tiger"
            , "Earth Rabbit"
            , "Metal Dragon"
            , "Metal Snake"
            , "Water Horse"
            , "Water Goat"
            , "Wood Monkey"
            , "Wood Rooster"
            , "Fire Dog"
            , "Fire Pig"
            , "Earth Rat"
            , "Earth Ox"
            , "Metal Tiger"
            , "Metal Rabbit"
            , "Water Dragon"
            , "Water Snake"
            , "Wood Horse"
            , "Wood Goat"
            , "Fire Monket"
            , "Fire Rooster"
            , "Earth Dog"
            , "Earth Pig"
            , "Metal Rat"
            , "Metal Ox"
            , "Water Tiger"
            , "Water Rabbit"
            , "Wood Dragon"
            , "Wood Snake"
            , "Fire Horse"
            , "Fire Goat"
            , "Earth Monkey"
            , "Earth Rooster"
            , "Metal Dog"
            , "Metal Pig"
            , "Water Rat"
            , "Water Ox"
            , "Wood Tiger"
            , "Wood Rabbit"
            , "Fire Dragon"
            , "Fire Snake"
            , "Earth Horse"
            , "Earth Goat"
            , "Metal Monkey"
            , "Metal Rooster"
            , "Water Dog"
            ]
    in
    Array.fromList zodiac
