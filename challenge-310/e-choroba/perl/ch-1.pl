#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub arrays_intersection(@list) {
    my %intersection;
    for my $i (0 .. $#list) {
        undef $intersection{$_}{$i} for @{ $list[$i] };
    }
    return [grep @list == keys %{ $intersection{$_} }, keys %intersection]
}

use Test2::V0;
plan 3 + 1;

is arrays_intersection([1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]),
    bag { item $_ for 1, 4; end() }, 'Example 1';

is arrays_intersection([1, 0, 2, 3], [2, 4, 5]),
    [2], 'Example 2';

is arrays_intersection([1, 2, 3], [4, 5], [6]),
    [], 'Example 3';

is arrays_intersection([1, 1, 1, 2, 2, 2, 3, 3, 3], [2, 2, 4, 4]),
    [2], 'non-unique arrays';
