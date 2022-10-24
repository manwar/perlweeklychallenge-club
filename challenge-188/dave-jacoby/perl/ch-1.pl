#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @input = (
    [ [ 4, 5, 1, 6 ], 2 ],
    [ [ 1, 2, 3, 4 ], 2 ],
    [ [ 1, 3, 4, 5 ], 3 ],
    [ [ 5, 1, 2, 3 ], 4 ],
    [ [ 7, 2, 4, 5 ], 4 ],
);

for my $input (@input) {
    my @list   = $input->[0]->@*;
    my $list   = join ', ', @list;
    my $k      = $input->[1];
    my $output = divisible_pairs( $k, @list );
    say <<"END";
        Input:  \@list = ($list) , \$k = $k
        Output: $output
END
}

sub divisible_pairs ( $k, @array ) {
    my $c = 0;
    for my $i ( 0 .. -1 + scalar @array ) {
        for my $j ( $i + 1 .. -1 + scalar @array ) {
            my $sum = $array[$i] + $array[$j];
            $c++ if 0 == $sum % $k;
        }
    }
    return $c;
}
