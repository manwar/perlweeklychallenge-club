#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ min };

# Should be rather fast :-)
sub array_degree (@array) {
    return [] unless @array;

    my %freq;
    my %from_to;
    my @max = (undef, 0);
    for my $pos (0 .. $#array) {
        my $e = $array[$pos];
        ++$freq{$e};
        if (exists $from_to{$e}) {
            $from_to{$e}[1] = $pos;
        } else {
            $from_to{$e} = [$pos, $pos];
        }
        if ($freq{$e} >= $max[-1]) {
            @max = ($freq{$e}) if $freq{$e} > $max[-1];
            unshift @max, $e;
        }
    }

    my %by_length = map +($_->[1] - $_->[0] => $_),
                    @from_to{@max[ 0 .. $#max - 1 ]};
    my $shortest = $by_length{ min(keys %by_length) };
    return [@array[ $shortest->[0] .. $shortest->[1] ]]
}

use Test2::V0;
plan 5 + 7;

is array_degree(1, 3, 3, 2), [3, 3], 'Example 1';
is array_degree(1, 2, 1, 3), [1, 2, 1], 'Example 2';
is array_degree(1, 3, 2, 1, 2), [2, 1, 2], 'Example 3';
is array_degree(1, 1, 2, 3, 2), [1, 1], 'Example 4';
is array_degree(2, 1, 2, 1, 1), [1, 2, 1, 1], 'Example 5';

is array_degree(1, 2, 3), [1], 'Degree 1';
is array_degree(), [], 'Degree 0';
is array_degree(1, 1, 2, 2, 3, 3, 3, 2, 1), [3, 3, 3], '3/3';
is array_degree(1, 1, 2, 2, 3, 3, 2, 3, 1), [3, 3, 2, 3], '3/4';
is array_degree(1, 1, 2, 3, 2, 3, 2, 3, 1), [2, 3, 2, 3, 2], '3/5';
is array_degree(1, 2, 3, 2, 1, 3, 2, 3, 1), [2, 3, 2, 1, 3, 2], '3/6';
is array_degree(1, 2, 3, 1, 2, 3, 1, 2, 3), [1, 2, 3, 1, 2, 3, 1], '3/7';
