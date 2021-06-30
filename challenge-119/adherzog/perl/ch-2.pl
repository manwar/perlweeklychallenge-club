#!/usr/bin/env perl

##############################################################################
# Perl Weekly Challenge #119
##############################################################################
#
# Task #2 - Sequence without 1-on-1
#
# Write a script to generate sequence starting at 1. Consider the increasing
# sequence of integers which contain only 1’s, 2’s and 3’s, and do not have
# any doublets of 1’s like below. Please accept a positive integer $N and
# print the $Nth term in the generated sequence.
#
# > 1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, …
#
##############################################################################

use strict;
use warnings;
use v5.10;

use Test::More;

if (@ARGV) {
    say get_nth_term_in_sequence(@ARGV);
}
else {
    my @tests = (
        { input => 1,    output => 1, },
        { input => 2,    output => 2, },
        { input => 3,    output => 3, },
        { input => 4,    output => 12, },
        { input => 5,    output => 13, },
        { input => 6,    output => 21, },
        { input => 7,    output => 22, },
        { input => 8,    output => 23, },
        { input => 9,    output => 31, },
        { input => 10,   output => 32, },
        { input => 11,   output => 33, },
        { input => 12,   output => 121, },
        { input => 13,   output => 122, },
        { input => 14,   output => 123, },
        { input => 15,   output => 131, },
        { input => 16,   output => 132, },
        { input => 17,   output => 133, },
        { input => 18,   output => 212, },
        { input => 60,   output => 2223, },
        { input => 200,  output => 31221, },
        { input => 1000, output => 1332223, },
    );

    for my $test (@tests) {
        my $output = get_nth_term_in_sequence( $test->{'input'} );
        is( $output, $test->{'output'} );
    }

    done_testing();
}

exit;

##############################################################################
#
# This is just a basic bruteforce implementation, but it works.
#
##############################################################################

sub get_nth_term_in_sequence {
    my $N = shift;

    my $term = 0;
    while ( $N > 0 ) {
        $term++;
        $N-- if ( $term =~ /^[123]+$/ && $term !~ /11/ );
    }

    return $term;
}
