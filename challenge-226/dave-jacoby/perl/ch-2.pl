#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ sum sum0 min max };

my @examples = ( [ 1, 5, 0, 3, 5 ], [0], [ 2, 1, 4, 0, 3 ], );

for my $e (@examples) {
    my $input  = join ',', $e->@*;
    my $output = zero_array( $e->@* );
    say <<~"END";
    Input:  \@ints = ($input)
    Output: $output
    END
}

sub zero_array( @ints ) {
    my $c = -1;
    while (1) {
        $c++;
        my $min = min grep { $_ > 0 } @ints;
        $min //= 0;
        @ints = map { $_ - $min > 0 ? $_ - $min : 0 } @ints;
        last if $min == 0;
        last if $c > 10;
    }
    return $c;
}
