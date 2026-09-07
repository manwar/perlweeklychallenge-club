#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 387 Task 1: Rearrange Binary String
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use Dsay;

sub rearrange_binary_string( $str ) {
    my $count = 0;
    ++$count
        while $str =~ s/01/10/g;
    return $count;
}

use lib qw( . ../../../lib );
use MultiTest;

my @tests = (
    [ "Example 1", "111000", 0 ],
    [ "Example 2", "00011", 4 ],
    [ "Example 3", "01011", 3 ],
    [ "Example 4", "010101", 3 ],
    [ "Example 5", "00001", 4 ],
    [ "Own Test 1", "00000", 0 ],
);

run( "rearrange_binary_string", \@tests );
