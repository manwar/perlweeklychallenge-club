#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ first };

sub reverse_equals($source, $target) {
    my $from = first { $source->[$_] != $target->[$_] } 0 .. $#$source;
    return 1 unless defined $from;

    my $to = first { $source->[$_] != $target->[$_] }
             reverse $from .. $#$source;

    for my $i (0 .. $to - $from) {
        return if $source->[ $from + $i ] != $target->[ $to - $i ];
    }

    return 1
}

use Test2::V0;

plan(3 + 3);

is reverse_equals([3, 2, 1, 4], [1, 2, 3, 4]), bool(1), 'Example 1';
is reverse_equals([1, 3, 4], [4, 1, 3]), bool(0), 'Example 2';
is reverse_equals([2], [2]), bool(1), 'Example 3';

is reverse_equals([1, 2, 3, 4], [1, 4, 3, 2]), bool(1), 'From the start';
is reverse_equals([1, 2, 3, 4], [1, 3, 2, 4]), bool(1), 'Inside';
is reverse_equals([1, 2, 3], [1, 2, 3]), bool(1), 'Same but longer';
