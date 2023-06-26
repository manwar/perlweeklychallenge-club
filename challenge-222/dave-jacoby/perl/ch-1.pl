#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples =
    ( 
        [ 1, 1, 4, 2, 1, 3 ], 
        [ 5, 1, 2, 3, 4 ], 
        [ 1, 2, 3, 4, 5 ], 
    );

for my $example (@examples) {
    my @matches = matching_members( $example->@* );
    my $s = scalar @matches;
    my $e = join ', ', $example->@*;
    say <<~"END";
        Input: \@ints = ($e);
        Output: $s
    END
}

sub matching_members( @ints) {
    my @output;
    my @sorted = sort { $a <=> $b } @ints;
    for my $i ( 0 .. -1 + scalar @ints ) {
        push @output, $ints[$i] if $ints[$i] == $sorted[$i];
    }
    return @output;
}
