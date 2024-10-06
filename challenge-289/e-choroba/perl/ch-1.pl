#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub third_maximum(@ints) {
    my %uniq;
    @uniq{@ints} = ();
    my @max3;

    for my $n (keys %uniq) {
        next if 3 == @max3 && $n <= $max3[2];

        push @max3, $n;
        @max3 = sort { $b <=> $a } @max3;
        pop @max3 if @max3 > 3;
    }
    return $max3[ 3 == @max3 ? 2 : 0 ]
}

use Test::More tests => 3 + 1;

is third_maximum(5, 6, 4, 1), 4, 'Example 1';
is third_maximum(4, 5), 5, 'Example 2';
is third_maximum (1, 2, 2, 3), 1, 'Example 3';

is third_maximum(1 .. 1000, 1 .. 1000), 998, 'Long';
