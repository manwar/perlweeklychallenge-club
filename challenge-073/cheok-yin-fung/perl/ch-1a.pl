#!/usr/bin/perl
# Perl Weekly Challenge #073 Task 1 Sliding Windows
# task statement:
# You are given an array of integers @A and sliding window size $S.
# Write a script to create an array of min from each sliding window.
# Usage:  ch-1a.pl $S $A[0] $A[1]  ... $A[-1]
# for large array size and large windows size , 
# while $S is much smaller than size of the array though

use strict;
use warnings;
#use Test::More tests => 7;

my $S;
my @A;

sub choosemin {
    my @array = @_;
    my $min = $array[0];
    my $minposition = 0;
    for my $i (1..$#array) {
        if ($array[$i] <= $min) {
            $min = $array[$i];
            $minposition = $i;
        }
    }
    return [$min, $minposition]; 
}

sub awindows {
    my $winsize = $_[0];
    my @array = @{$_[1]};
    my @smallkids = ();
    my $min = undef;
    my $minposition = undef;
    
    for my $winposition (0..$#array-$winsize+1) {
        if ($min) {
            my $i = $winsize - 1;
            my $ele = $array[$winposition+$i]; 
            if ($ele <= $min) {
                $minposition = $i;
                $min = $ele;
            }
        } else {
            ($min, $minposition) 
            = @{choosemin(@array[$winposition..$winposition+$winsize-1])};
        }
        push @smallkids, $min;
        if ($minposition == 0) {
            $min = undef;
            $minposition = undef;
        } else {
            $minposition--;
        }
    }
    return [@smallkids];
}

if ($ARGV[0] and $ARGV[1]) {
    $S = shift @ARGV;
    @A = @ARGV;
} else {
    $S = 7;
    @A = qw/15 23 31 39 9 22 31 25 50 46 44 19 15 9 41 45 8 35 20 10/ ;
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
is_deeply( awindows(2, [qw/7 3 19 17 1 3 37 45 4 23 39 18 17 9 14
                32 25 34 22 21 45 37 46 4 31 15 41 23 8 20/]),
            [qw/3 3 17 1 1 3 37 4 4 23 18 17 9 9 14 25 25 
                22 21 21 37 37 4 4 15 15 23 8 8/], 
            "oh a long list, window size is 3");
is_deeply( awindows(3, [qw/7 3 19 17 1 3 37 45 4 23 39 18 17 9 14
                32 25 34 22 21 45 37 46 4 31 15 41 23 8 20/]),
        [qw/3 3 1 1 1 3 4 4 4 18 17 9 9 9 14 25 22 21 21 21 37
         4 4 4 15 15 8 8/], "a list same as above but window size is 3");
is_deeply( awindows(7, [ qw/15 23 31 39 9 22 31 25 50 46 44
            19 15 9 41 45 8 35 20 10/ ]), 
        [qw/9 9 9 9 9 19 15 9 9 9 8 8 8 8/],
        "a long list with 20 elements, with window size 7");
=cut
