#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 215 Task 1: Number Placement
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

sub number_placement {
    my ( $numbers, $count ) = @_;
    my $string = join "", @$numbers;
    $string =~ s/(?<!1)0(?!1)/1/ or return 0
        for 1..$count;
    return 1;
}


use Test2::V0;
use Data::Dump qw( pp );

# The test data extraction machine:
my @tests;
my $test_object;
my $test_sub;

while ( <DATA> ) {
    chomp $_;

    /^Task [12]:\s*(.*)/ and do {
        ( $test_object = lc $1 ) =~ s/[^a-z]+/_/g;
        $test_sub = \&$test_object;
    };

    /^Example \d+/ and do {
        push @tests, { TEST => $& };
        next;
    };

    /Input: / and do {
        /\@\w+ = \(\s*(.*?)\s*[,]?\)/ and do {
            my @list = map { s/'(.*?)'/$1/; $_ } split /, ?/, $1;
            push @{$tests[-1]{INPUT}}, [ @list ];
        };
        /\$\w+ = \s*(\d+)\s*/ and do {
            push @{$tests[-1]{INPUT}}, $1;
        };
        next;
    };
    /Output: (.*)/ and do {
        push @{$tests[-1]{OUTPUT}}, $1;
        next;
    };
}

do {
    if ( scalar @{$_->{INPUT}} == 1 ) {
        is $test_sub->( @{$_->{INPUT}[0]} ), $_->{OUTPUT}[0],
            "$_->{TEST}: $test_object( @{$_->{INPUT}[0]} ) == $_->{OUTPUT}[0]";
    }
    else {
        is( $test_sub->( @{$_->{INPUT}} ), $_->{OUTPUT}[0],
            "$_->{TEST}: $test_object( "
                . ( join ", ", map pp( $_ ), @{$_->{INPUT}} )
                . " ) == $_->{OUTPUT}[0]" );
    }
} for @tests;

done_testing;

# { INPUT => [ 1,2,3,4,5,6 ], EXPECTED => [ 2,4,6,1,3,5 ] },
#     { INPUT => [ 1,2 ], EXPECTED => [ 2,1 ] },
#     { INPUT => [ 1 ], EXPECTED => [ 1 ] },

__DATA__

Task 2: Number Placement
Submitted by: Mohammad S Anwar

You are given a list of numbers having just 0 and 1. You are also given placement count (>=1).

Write a script to find out if it is possible to replace 0 with 1 in the given list. The only condition is that you can only replace when there is no 1 on either side. Print 1 if it is possible otherwise 0.
Example 1:

Input: @numbers = (1,0,0,0,1), $count = 1
Output: 1

You are asked to replace only one 0 as given count is 1.
We can easily replace middle 0 in the list i.e. (1,0,1,0,1).

Example 2:

Input: @numbers = (1,0,0,0,1), $count = 2
Output: 0

You are asked to replace two 0's as given count is 2.
It is impossible to replace two 0's.

Example 3:

Input: @numbers = (1,0,0,0,0,0,0,0,1), $count = 3
Output: 1


Example 4:
(checking whether the handling of 'there is no 1 on either side'
is correct at the beginning and end of the list.
Input: @numbers = (0,0,0), $count = 2
Output: 1
