#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1 && length $ARGV[0] > 2;
usage: $0 [-examples] [-tests] [-verbose] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    show the found additive sequence instead of a true / false result

STR
    a string of decimal digits having a minimum length of three

EOS


### Input and Output

say $verbose ?
    "(@{is_additive(@ARGV) // []})" :
    is_additive(@ARGV) ? 'true' : 'false';


### Implementation

# The task states: "An additive number is a string whose digits can form
# an additive sequence."  I see some ambiguity in the phrase "digits can
# form an additive sequence".  What is the meaning of "form"?  We might
# pick arbitrary digits to build numbers.  However, the examples suggest
# that we shall split the given string to get the numbers.  As this
# interpretation significantly simplifies the task, I'll follow it.
#
# The first two numbers may be chosen freely from the head of the
# string.  However, there are restrictions to their lengths: 
# - The maximum length of the first number must leave enough room for a
#   second number of length one and a tail of the same length as the
#   first number.
# - The maximum length of the second number must leave enough room for a
#   tail of the lengths of both, the first and the second number.
# Starting with all starting pairs conforming to above restrictions, we
# check if the remaining string follows the additive sequence generated
# by the starting pair.  Collecting the additive sequence along the way.

sub is_additive ($s) {
    my $l = length $s;
    for (my $lx = 1; 2 * $lx + 1 <= $l; $lx++) {
        for (my $ly = 1; 2 * $lx + $ly <= $l && $lx + 2 * $ly <= $l;  $ly++) {
            my $x = substr $s, 0, $lx;
            my $y = substr $s, $lx, $ly;
            my $z = $x + $y;
            my @seq = ($x, $y);
            ($x, $y, $z) = ($y, $z, $y + $z, push @seq, $z)
                while $s =~ /\G$x(?=$y$z)/gc; # set "pos" between x and y
            return \@seq if $s =~ /\G$x$y$/g;
        }
    }
    undef;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is is_additive(112358), [qw(1 1 2 3 5 8)], 'example 1';
        ok !is_additive(12345), 'example 2';
        is is_additive(199100199), [qw(1 99 100 199)], 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is is_additive(11112111311152228), [qw(1111 2 1113 1115 2228)],
            'a bit longer';
        is is_additive('011'), [qw(0 1 1)], 'leading zero';
	}

    done_testing;
    exit;
}
