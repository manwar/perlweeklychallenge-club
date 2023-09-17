#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ uniq };

my @examples = (

    [ 4, 4, 2, 4,  3 ],
    [ 1, 1, 1, 1,  1 ],
    [ 4, 7, 1, 10, 7, 4, 1, 1 ],
);

for my $e (@examples) {
    my @ints   = $e->@*;
    my $ints   = join ',', @ints;
    my $output = unequal_triplets(@ints);
    say <<~"END";
    Input:  \@ints = ($ints)
    Output: ($output)
    END
}

sub unequal_triplets (@ints) {
    my $c = 0;
    for my $i ( 0 .. -1 + scalar @ints ) {
        for my $j ( $i + 1 .. -1 + scalar @ints ) {
            for my $k ( $j + 1 .. -1 + scalar @ints ) {
                next if $ints[$i] == $ints[$j];
                next if $ints[$i] == $ints[$k];
                next if $ints[$j] == $ints[$k];
                $c++;
            }
        }
    }
    return $c;
}
