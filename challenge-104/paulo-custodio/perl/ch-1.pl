#!/usr/bin/perl

# Challenge 104
#
# TASK #1 › FUSC Sequence
# Submitted by: Mohammad S Anwar
# Write a script to generate first 50 members of FUSC Sequence. Please refer to
# OEIS for more information.
#
# The sequence defined as below:
#
# fusc(0) = 0
# fusc(1) = 1
# for n > 1:
# when n is even: fusc(n) = fusc(n / 2),
# when n is odd: fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)

use strict;
use warnings;
use 5.030;

my $N = shift // 50;
for my $i (0 .. $N-1) {
    print fusc($i), " ";
}
say "";

sub fusc {
    my($n) = @_;
    state @fusc;
    return $fusc[$n] if defined $fusc[$n];
    return 0 if $n==0;
    return 1 if $n==1;

    if (($n & 1)==0) {      # even
        return $fusc[$n] = fusc($n/2);                      # assign and return
    }
    else {
        return $fusc[$n] = fusc(($n-1)/2) + fusc(($n+1)/2); # assign and return
    }
}
