#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ uniq };

my @examples =
    ( [ 1, 3, 4, 5, 7 ], [ 1, 2, 3, 6, 7, 9 ], [ 0, 1, 2, 4, 5, 6, 8, 9 ], );

for my $e (@examples) {
    my @array  = $e->@*;
    my @output = range_list(@array);
    my $array  = join ', ', @array;
    my $output = join ', ',
        map { qq{[$_]} } map { join ', ', $_->@* } @output;
    say <<"END";
    Input: \@array = ($array)
    Output: $output
END
}

sub range_list ( @array ) {
    my @output;
    my $k = 0;
OUTER: for my $i ( 0 .. -1 + scalar @array ) {
        next if $i < $k;
        my @block = ( $array[$i], -1 );
        for my $j ( $i + 1 .. -1 + scalar @array ) {
            if ( $array[ $j - 1 ] + 1 == $array[$j] ) {
                $block[1] = $array[$j];
            }
            else {
                $k = $j;
                next OUTER;
            }
            push @output, \@block;
        }
    }
    return map { [ split /,/, $_ ] } uniq map { join ',', $_->@* } @output;
}
