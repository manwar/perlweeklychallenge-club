#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ any max };

my @examples = (

    [ 5, 4, 0, 3, 1, 6, 2 ],
    [ 0, 1, 2 ],
    [ 2, 0, 1, 3 ],
);

for my $example (@examples) {
    my $ints   = join ', ', $example->@*;
    my $output = nested_array( $example->@* );
    say <<"END";
    Input:  \@ints = ($ints)
    Output: $output
END
}

sub nested_array(@array) {
    my @loops;
OUTER: for my $i ( 0 .. -1 + scalar @array ) {
        my $flag = 1;
        my @nested;
        my $n = $i;
        while ($flag) {
            if ( any { $n == $_ } @nested ) {
                push @loops, scalar @nested;
                next OUTER;
            }
            else { my $v = $array[$n]; push @nested, $n; $n = $v; }
        }
    }
    return max @loops;
}
