#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub mad(@ints) {
    my @sorted = sort { $a <=> $b } @ints;
    my @mad = ($sorted[1] - $sorted[0]);
    for my $i (1 .. $#sorted) {
        my $diff = abs($sorted[$i] - $sorted[ $i - 1 ]);
        if ($diff < $mad[0]) {
            @mad = ($diff);
        }
        if ($diff == $mad[0]) {
            push @mad, [@sorted[$i - 1, $i]];
        }
    }
    return @mad[1 .. $#mad]
}

use Test2::V0;
plan(3);

use experimental qw( signatures );  # Needed again after Test2::V0;
sub bagobags(@elements) {
    bag {
        item(bag { item($_) for @$_; end() }) for @elements;
        end();
    }
}

is [mad(4, 1, 2, 3)], bagobags([1,2], [2,3], [3,4]), 'Example 1';
is [mad(1, 3, 7, 11, 15)], bagobags([1,3]), 'Example 2';
is [mad(1, 5, 3, 8)], bagobags([1,3], [3,5]), 'Example 3';
