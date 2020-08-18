#!/usr/bin/perl
# Perl Weekly Challenge #073 Task 1 Sliding Windows
# task statement:
# You are given an array of integers @A and sliding window size $S.
# Write a script to create an array of min from each sliding window.
# Usage:  ch-1.pl $S $A[0] $A[1]  ... $A[-1]

use strict;
use warnings;
use List::Util qw/min/;
#use Test::More tests => 4;

sub awindows {
    my $winsize = $_[0];
    my @array = @{$_[1]};
    my @smallkids = ();
    # loop: look for the smallest element on the sliding window:
    for my $i (0..$#array-$winsize+1) {
        push @smallkids, min @array[$i..$i+$winsize-1];
    }
    return [@smallkids];
}

my $S;
my @A;

if ($ARGV[0] and $ARGV[1]) {
    $S = shift @ARGV;
    @A = @ARGV;
} else {
    $S = 3;
    @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8);
}

print join " ", @{ awindows($S, [@A])};
print "\n";


=pod
is_deeply( awindows(3, [1, 5, 0, 2, 9,  3, 7, 6, 4, 8]), 
    [0, 0, 0, 2, 3,  3, 4, 4], "example provided") ;
is_deeply( awindows(3, [ 10, 47, 16, 50, 29,  21, 18, 20, 6, 30,  11]), 
    [10, 16, 16, 21, 18,  18,  6 , 6,   6  ], "eleven random numbers");
is_deeply( awindows(2, [2, 3, 5, 7, 11, 13, 17]), 
    [2, 3, 5, 7, 11, 13], "ascending sequences");
is_deeply( awindows(4, [reverse 1..10]),
    [reverse 1..7], "descending first 10 positive integers");
=cut
