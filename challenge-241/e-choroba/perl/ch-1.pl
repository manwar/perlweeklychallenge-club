#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub arithmetic_triplets($diff, @nums) {
    my %in;
    @in{@nums} = ();

    my $count = 0;
    for my $num (@nums) {
        ++$count if exists $in{ $num + $diff }
                 && exists $in{ $num + 2 * $diff };
    }
    return $count
}

use Test::More tests => 2 + 1;

is arithmetic_triplets(3, 0, 1, 4, 6, 7, 10), 2, 'Example 1';
is arithmetic_triplets(2, 4, 5, 6, 7, 8, 9), 2, 'Example 2';
is arithmetic_triplets(10, 1 .. 19), 0, 'None';
