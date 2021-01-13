#!/usr/bin/env perl

###########################################################################
# script name: ch-1.pl                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-055/         #
#                                                                         #
# Flip Binary                                                             #
#                                                                         #
# You are given a binary number B, consisting of N binary digits          #
# 0 or 1: s0, s1, ..., s(N-1).                                            #
#                                                                         #
# Choose two indices L and R such that 0 <= L <= R < N and flip the       #
# digits s(L),s(L+1), ... , s(R) By flipping, we mean changing 0 to 1     #
# and vice-versa.                                                         #
#                                                                         #
# Write a script to find the indices (L,R) that results in a              #
# binary number with maximum number of 1s. If you find more than one      #
# maximal pair L,R then print all of them.                                #
#                                                                         #
# Continuing our example, note that we had three pairs (L=0, R=0),        #
# (L=0, R=2), and (L=2, R=2) that resulted in a binary number with        #
# two 1s, which was the maximum. So we would print all three pairs.       #
#                                                                         #
###########################################################################

use strict;
use warnings;

my $originalString = "010";

if (@ARGV) {
    $originalString = "$ARGV[0]";
    if ( $originalString =~ m{[^01]} ) {
        print STDERR "Arguments can only contain 1s and 0s.\n";
        exit(1);
    }
} else {
    print STDERR "No arguments given. Using example data: 010\n";
}

my $n = length $originalString;

my $lowerBound = 0;
my $upperBound = $n;

my $max = 0;
my @maxes = ();

my $hasZeroes = 0;
if ($originalString =~ m{0} ) {
    $hasZeroes = 1;
}

if ( $originalString =~ m{\A(1+)} and $hasZeroes) {
    $lowerBound = length $1;
}

if ( $originalString =~ m{(1+)\Z} and $hasZeroes) {
    my $difference = length $1;
    $upperBound = $n - $difference;
}

for (my $left = $lowerBound; $left <= $upperBound; ++$left) {
    for (my $right = $left+1; $right <= $upperBound; ++$right) {

        my $binaryString = $originalString;
        my $offset = $right - $left;

        my $replace = substr $binaryString, $left, $offset;
        $replace =~ tr{01}{10};
        substr $binaryString, $left, $offset, $replace;

        my $num = () = $binaryString =~ m{1}g;

        if ($num > $max) {
            $max = $num;
            @maxes = ();
            push @maxes, sprintf("(L=%d, R=%d)", $left, $right-1);
        } elsif ($num == $max) {
            push @maxes, sprintf("(L=%d, R=%d)", $left, $right-1);
        }
    }
}

print "$_ " foreach @maxes;
print "\n";
