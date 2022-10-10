#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

use List::Util qw{ max };
my @inputs = ( [ 5, 2, 9, 1, 7, 6 ], [ 4, 2, 3, 1, 5, 0 ] );

for my $n (@inputs) {
    my $input     = join ' ', $n->@*;
    my $max_index = max_index( $n->@* );
    say <<"END";
    INPUT:  \@n = ($input)
    OUTPUT: $max_index
END
}

sub max_index ( @array ) {
    my $max = max @array;
    for my $i ( 0 .. -1 + scalar @array ) {
        return $i if $max == $array[$i];
    }
    return -1;
}
