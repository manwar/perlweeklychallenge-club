#!/usr/bin/env raku

use v6;

#| Given a list of integers return the majority nummber of -1 if there isn't one
sub MAIN ( *@numbers where .all ~~ Int ) {
    my $mid = floor( @numbers.elems / 2 );
    say @numbers.Bag.kv.grep( -> $v, $c { $c > $mid })[0][0] // -1;
}
