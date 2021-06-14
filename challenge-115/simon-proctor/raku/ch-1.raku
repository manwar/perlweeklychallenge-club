#!/usr/bin/env raku

sub MAIN( \file = "ch1.csv" ) {
    ( (1..15) (^) file.IO.lines.map( *.split(",")[0].Int ) ).keys.first.say;
}