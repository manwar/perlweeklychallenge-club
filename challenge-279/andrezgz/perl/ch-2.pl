#!/usr/bin/perl

# https://theweeklychallenge.org/blog/perl-weekly-challenge-279/
# Task #2 > Split String
#
# You are given a string, $str.
#
# Write a script to split the given string into two containing exactly same number of vowels and return true if you can otherwise false.
#

use strict;
use warnings;
use Test2::V0 '-no_srand';

my @tests = (
    [ 'perl', 'false' ],
    [ 'book', 'true' ],
    [ 'good morning', 'true' ],
);

for my $test (@tests) {
    my ($str, $expected) = @$test;
    my $splits = splits_with_equal_vowels($str);
    is any_valid_split($splits) ? 'true' : 'false', $expected;
}

done_testing;

sub any_valid_split {
    my $splits = shift;
    return !! scalar @$splits;
}

sub splits_with_equal_vowels {
    my $str = shift;

    # count the number of vowels
    my $vowels = $str =~ tr/aeiouAEIOU//;
    return [] if $vowels % 2; # odd number of vowels

    my $res = [];
    my $count_vw = 0;
    for my $i (0 .. length($str)/2 - 1) {
        ++$count_vw if substr($str, $i, 1) =~ /[aeiou]/i;
        next unless $count_vw == $vowels / 2; # not a valid split point
        push @$res, [ substr($str, 0, $i+1), substr($str, $i + 1)];
    }

    return $res;
}
