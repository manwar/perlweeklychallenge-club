#!/usr/bin/env raku

#| Find the longest word in the given list that when sorted alphabetically is the same
sub MAIN( $dict = "/etc/dictionaries-common/words" ) {
    $dict.IO.lines.hyper.grep( { $_.lc ~~ $_.lc.split("").sort.join("") } ).sort( *.chars ).reverse.first.say;
}
