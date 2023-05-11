#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 215 Task 1: Odd one Out
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use List::Util qw( sum reduce );

sub odd_one_out {
    return sum
        map ! defined ( reduce { defined $a && $a le $b ? $b : undef } /./g ),
            @_;
}


use Test2::V0;
use Data::Dump qw( pp );

# The test data extraction machine:
my @tests;
my $test_object = "odd_one_out";
my $test_sub = \&$test_object;

while ( <DATA> ) {
    chomp $_;

    /^Example/ and do {
        push @tests, { TEST => $_ };
        next;
    };

    /Input: / and do {
        /\@\w+ = \(\s*(.*?)\s*[,]?\)/ and do {
            my @list = map { s/'(.*?)'/$1/; $_ } split /, /, $1;

            push @{$tests[-1]{INPUT}}, [ @list ];
            next;
        };
    };
    /Output: (.*)/ and do {
        push @{$tests[-1]{OUTPUT}}, $1;
        next;
    };
}

do {
    is $test_sub->( @{$_->{INPUT}[0]} ), $_->{OUTPUT}[0],
        "$_->{TEST}: $test_object( @{$_->{INPUT}[0]} ) == $_->{OUTPUT}[0]";
} for @tests;

done_testing;

# { INPUT => [ 1,2,3,4,5,6 ], EXPECTED => [ 2,4,6,1,3,5 ] },
#     { INPUT => [ 1,2 ], EXPECTED => [ 2,1 ] },
#     { INPUT => [ 1 ], EXPECTED => [ 1 ] },

__DATA__

Task 1: Odd one Out
Submitted by: Mohammad S Anwar

You are given a list of words (alphabetic characters only) of same size.

Write a script to remove all words not sorted alphabetically and print the number of words in the list that are not alphabetically sorted.

Example 1

Input: @words = ('abc', 'xyz', 'tsu')
Output: 1

The words 'abc' and 'xyz' are sorted and can't be removed.
The word 'tsu' is not sorted and hence can be removed.

Example 2

Input: @words = ('rat', 'cab', 'dad')
Output: 3

None of the words in the given list are sorted.
Therefore all three needs to be removed.

Example 3

Input: @words = ('x', 'y', 'z')
Output: 0
