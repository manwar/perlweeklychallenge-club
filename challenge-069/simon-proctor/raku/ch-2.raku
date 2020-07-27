#!/usr/bin/env raku

#| Calculate S1000 where see https://perlweeklychallenge.org/blog/perl-weekly-challenge-069/
multi sub MAIN ( UInt $S = 30 ) {
    my @ret = [];
    my $count = 0;
    while $S > $count {
        @ret .= push( "0", @ret.hyper.reverse.map(*.trans(<0 1> => <1 0>)).Slip );
        $count++;
    }
    say @ret.join("");
}



