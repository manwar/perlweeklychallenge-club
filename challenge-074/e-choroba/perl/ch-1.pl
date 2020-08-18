#! /usr/bin/perl
use warnings;
use strict;

# int can be used instead of floor as
# floor($x) == int($x) for $x >= 0,
# and size of an array can never be negative.

sub majority_element {
    my @arr = @_;
    my %count;
    for my $e (@arr) {
        return $e if ++$count{$e} > int(@arr / 2);
    }
    return -1
}

use Test::More tests => 2;

is majority_element(1, 2, 2, 3, 2, 4, 2),
    2,
    'example 1';

is majority_element(1, 3, 1, 2, 4, 5),
    -1,
    'example 2';
