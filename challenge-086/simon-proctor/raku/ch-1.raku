#!/usr/bin/env raku

use v6;

#| Given a number and a list of integers return 1 if the numbert is the difference of any two
#| of the integers. Otherwise return 0.
sub MAIN (
    Int $A, #= Difference to look for
    *@N where { $_.all ~~ Int }, #= List of integers to check
) {
    say +so (any(@N) - any(@N) == $A);
}
