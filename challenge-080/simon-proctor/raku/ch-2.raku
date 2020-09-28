#!/usr/bin/env raku

use v6;

#| Given a list of scores work out how many candies you need given these rules :
#| a) You must given at least one candy to each candidate.
#| b) Candidate with higher ranking get more candies than their mmediate neighbors on either side.
sub MAIN (
    *@N where { $_.all ~~ Int } #= List of scores
) {
    my $max = @N.max + 1;
    say [+] ($max, |@N, $max).rotor(3 => -2).map( -> ($l, $c, $r ) { [+] ($c > $l, 1, $c > $r ) } )
}
