#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub distribute_elements($x, $y, $ints) {
    my @agenda = ([0, [sort { $a <=> $b } @$ints]]);
    my %seen;
    while (1) {
        my ($price, $elements) = @{ shift @agenda };
        if ($elements->[0] == $elements->[-1]) {
            return $price
        }

        my @e = sort { $a <=> $b }
                $elements->[0] + 1, @$elements[1 .. $#$elements];
        $seen{"@e"} = $price + $x,
        push @agenda, [$price + $x, \@e] if ! exists $seen{"@e"}
                                         || $seen{"@e"} > $price + $x;

        if (@$elements > 2 && 2 * $x > $y) {
            for my $i (1, $#$elements) {
                my @e = sort { $a <=> $b } $elements->[0] + 1,
                                           $elements->[$i] + 1,
                                           @$elements[grep $_ != 0
                                                           && $_ != $i,
                                                      0 .. $#$elements];

                $seen{"@e"} = $price + $y,
                push @agenda, [$price + $y, \@e]
                    if ! exists $seen{"@e"}
                    || $seen{"@e"} > $price + $y;
            }
        }

        @agenda = sort { $a->[0] <=> $b->[0] } @agenda;
    }
}

use Test::More tests => 2 + 17;

is distribute_elements(3, 2, [4, 1]), 9, 'Example 1';
is distribute_elements(2, 1, [2, 3, 3, 3, 5]), 6, 'Example 2';

is distribute_elements(3, 1, [1, 2, 2]), 2, '3 1 [1 2 2]';
is distribute_elements(4, 1, [1, 2, 2, 2, 2]), 3, '4 1 [1 2 2 2 2]';
is distribute_elements(20, 1, [1, 2, 3, 3]), 21, '20 1 [1 2 3 3]';
is distribute_elements(20, 1, [1, 2, 4, 4]), 22, '20 1 [1 2 4 4]';
is distribute_elements(1, 7, [2, 2, 3, 5]), 8, '1 7 [2 2 3 5]';
is distribute_elements(7, 1, [2, 2, 3, 5]), 4, '7 1 [2 2 3 5]';
is distribute_elements(2, 3, [1, 1, 5]), 12, '2 3 [1 1 5]';
is distribute_elements(17, 1, [1, 9, 9]), 16, '17 1 [1 9 9]';
is distribute_elements(8, 9, [6, 6, 4, 2]), 34, '8 9 [6 6 4 2]';
is distribute_elements(6, 1, [2, 5, 5, 6]), 5, '6 1 [2 5 5 6]';
is distribute_elements(9, 1, [1, 2, 3, 3, 7]), 12, '9 1 [1 2 3 3 7]';
is distribute_elements(7, 3, [1, 4, 7, 7, 7]), 21, '7 3 [1 4 7 7 7]';
is distribute_elements(9, 1, [7, 1, 1, 4, 8]), 12, '9 1 [7 1 1 4 8]';
is distribute_elements(1, 1, [1, 4, 3, 4, 5, 4, 2, 3, 7]), 15,
    '1 1 [1 4 3 4 5 4 2 3 7]';
is distribute_elements(4, 1, [1, 4, 1, 2, 5, 7, 1, 5]), 15,
    '4 1 [1 4 1 2 5 7 1 5]';
is distribute_elements(6, 10, [2, 3, 5, 1, 2, 1, 1, 7]), 170,
    '6 10 [2 3 5 1 2 1 1 7]';
is distribute_elements(4, 4, [4, 4, 1, 7, 2, 7, 1, 1, 4]), 64,
    '4 4 [4 4 1 7 2 7 1 1 4]';
