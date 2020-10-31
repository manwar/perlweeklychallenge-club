#!/usr/bin/env perl

use v5.20;
use strict;
use warnings;
use feature qw(signatures);
no warnings qw(experimental::signatures);

=pod
TASK #1 › Reverse Integer
Submitted by: Mohammad S Anwar

You are given an integer $N.

Write a script to reverse the given integer and print the result. Print 0 if the result doesn’t fit in 32-bit signed integer.

The number 2,147,483,647 is the maximum positive value for a 32-bit signed binary integer in computing.
Example 1:

Input: 1234
Output: 4321

Example 2:

Input: -1234
Output: -4321

Example 3:

Input: 1231230512
Output: 0
=cut

#<<<
sub reverse_integer($N) {
    my $M = reverse abs $N, '-'x($N<0);
    $M*(-2**31<=$M<2**31);
}
#>>>

my $int = qr/-?\d+/;

if ( @ARGV && $ARGV[0] =~ /^$int$/ ) {
    say reverse_integer( $ARGV[0] );
}
else {
    say "Usage: $0 <Integer>";
}

# Tests.
while (<DATA>) {
    if (/^($int)\s+($int)$/) {
        my $actual = reverse_integer($1);
        $2 eq $actual || die "Error for $1. Expected $2, got $actual.";
    }
}

__DATA__
# Test data of the form <Input> <Expected Output>
1234 4321
-1234 -4321
1231230512 0
