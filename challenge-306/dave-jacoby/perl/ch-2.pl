#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ first };

my @examples = (

    [ 3, 8, 5, 2, 9, 2 ],
    [ 3, 2, 5 ],
);

for my $example (@examples) {
    my $ints   = join ', ', $example->@*;
    my $output = last_element( $example->@* );
    say <<"END";
    Input:  \@ints = ($ints)
    Output: $output
END
}

sub last_element(@ints) {
    while ( scalar @ints > 1 ) {
        my ( $y, $x ) = sort { $b <=> $a } @ints;
        if ( $x == $y ) {
            # there's ugly enough that, if I was to rewrite this,
            # I would separate this into a function, probably.
            # As a one-off, it isn't worth it.
            my $ix = first { $ints[$_] == $x } 0 .. $#ints;
            $ints[$ix] = undef;
            @ints = grep { defined } @ints;
            my $iy = first { $ints[$_] == $y } 0 .. $#ints;
            $ints[$iy] = undef;
            @ints = grep { defined } @ints;
        }
        else {
            my $yx = $y - $x;
            my $iy = first { $ints[$_] == $y } 0 .. $#ints;
            $ints[$iy] = undef;
            @ints = grep { defined } @ints;
            my $ix = first { $ints[$_] == $x } 0 .. $#ints;
            $ints[$ix] = $yx;
            @ints = grep { defined } @ints;
        }
    }
    return scalar @ints;
}
