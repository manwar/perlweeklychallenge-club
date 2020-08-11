#!/usr/bin/env perl6
# Accept a string from command line and split it on change of character.

sub MAIN (Str $string ="ABBCDEEF") {

    $string.match: / ( $<l>=<.alpha> $<l>* )+ /;    # Quantified capture yields array $/[0] of Match objects
    say $/[0][*].Str;                               # Stringify each Match object to see the overall match

}