#!/usr/bin/env raku

#| Given a year between 1753 and 9999 print the number of friday the 13ths
sub MAIN(
    Int() $year where 1753 <= * <= 9999 #= Year between 1753 and 9999
) {
    (1..12)
    .map( -> $m { Date.new($year,$m,13) } )
    .grep( -> $d { $d.day-of-week == 5 } )
    .elems
    .say;
}
