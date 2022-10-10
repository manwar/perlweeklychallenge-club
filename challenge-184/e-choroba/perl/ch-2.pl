#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::MoreUtils qw{ part };

sub split_array (@strings) {
    my @results;
    for my $string (@strings) {
        my ($digits, $letters) = part { /[a-z]/ } split ' ', $string;
        push @{ $results[0] }, $digits  if $digits;
        push @{ $results[1] }, $letters if $letters;
    }
    return \@results
}

use Test2::V0;
plan 2;

is split_array( 'a 1 2 b 0', '3 c 4 d'),
    [[[1,2,0], [3,4]], [['a','b'], ['c','d']]],
    'Example 1';

is split_array('1 2', 'p q r', 's 3', '4 5 t'),
    [[[1,2], [3], [4,5]], [['p','q','r'], ['s'], ['t']]],
    'Example 2';
