#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Algorithm::Combinatorics qw{ variations };
use List::Util qw{ sum };

sub largest_of_three(@ints) {
   my $max = -1;
    for my $length (reverse 1 .. @ints) {
        for my $var (variations(\@ints, $length)) {
            next unless 0 == sum(@$var) % 3;

            my $candidate = 0 + join "", @$var;
            $max = $candidate if $candidate > $max;
        }
    }
    return $max
}

use Test::More tests => 3 + 6;

is largest_of_three(8, 1, 9), 981, 'Example 1';
is largest_of_three(8, 6, 7, 1, 0), 8760, 'Example 2';
is largest_of_three(1), -1, 'Example 3';

is largest_of_three(0, 0, 0), 0, 'Zero';
is largest_of_three(4, 8, 911), 9114, 'n>9';
is largest_of_three(8, 85, 0), 8850, 'n>9';
is largest_of_three(8, 89, 2), 8982, 'n>9';
is largest_of_three(8, 76, 0), 8760, 'n>9';
is largest_of_three(8, 94, 0), 9480, 'n>9';
