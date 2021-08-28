#!/usr/bin/env raku

subset CommaSep of Str where { $_ ~~ m/^ [\d+] + % ',' $/ };

#| Given 2 comma seperated lists print 1 if they have not similar values
sub MAIN( CommaSep $a, CommaSep $b ) {
    say +! (($a.split(",")) (&) ($b.split(","))).keys.elems;
}
