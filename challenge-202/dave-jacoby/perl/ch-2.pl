#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ sum0 uniq };

my @examples = (

    [ 1, 5, 5,  2, 8 ],
    [ 2, 6, 8,  5 ],
    [ 9, 8, 13, 13, 2, 2, 15, 17 ],
    [ 2, 1, 2,  1,  3 ],
    [ 1, 3, 3,  2,  1, 2, 3, 3, 2 ],
);

for my $e (@examples) {
    my $example = join ', ', $e->@*;
    my @valley  = widest_valley( $e->@* );
    my $valley  = join ', ', @valley;
    say <<"END";
    Input:  \$n = $example
    Output: $valley
END
}

sub widest_valley ( @array ) {
    my @output;
    my $end = -1 + scalar @array;

OUTER: for my $i ( 0 .. $end ) {

        # 0 = non-increasing, 1 = non-decreasing
        my $state = 0;
        my @local;
        for my $j ( $i .. $end ) {
            my $n = $array[$j];

            # descending
            if ( $state == 0 && scalar @local && $n > $local[-1] ) {
                $state = 1;
            }
            elsif ( $state == 1 && $n < $local[-1] ) {
                next OUTER;
            }
            push @local, $n;
            my @copy = @local;
            push @output, \@copy if scalar @copy > 2;
        }
    }

    @output = sort { scalar $b->@* <=> scalar $a->@* } @output;
    return () unless scalar @output;
    return $output[0]->@*;
}

