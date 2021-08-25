#!/usr/bin/perl
# The Weekly Challenge 127
# Task 1 Disjoint Sets
# Usage: $ ch-1.pl 
use v5.12.0;
no warnings;
use experimental qw/signatures/;
use Test::More tests => 5;

sub disjoint ($s1 , $s2) {
    my @S1 = sort $s1->@*;
    my @S2 = sort $s2->@*;

    my (@Ss, @Sl);

    if (scalar @S1 > scalar @S2) {
        @Ss = @S2;
        @Sl = @S1;
    }
    else {
        @Ss = @S1;
        @Sl = @S2;
    }

    my $ref_ind = 0;
    for (0..$#Ss) {
        while ($Sl[$ref_ind] < $Ss[$_]) {
            last if $ref_ind == $#Sl;
            $ref_ind++;
        }
        return 0 if $Sl[$ref_ind] == $Ss[$_];
    }

    return 1;
}

ok disjoint( [1, 2, 5, 3, 4], [4, 6, 7, 8, 9] ) == 0, 
    "Example 1";
ok disjoint( [1, 3, 5, 7, 9], [0, 2, 4, 6, 8] ) == 1, 
    "Example 2";

ok disjoint( [1, 3, 5, 7], [0, 2, 4, 6, 7] ) == 0,
    "Test case 1";

ok disjoint( [7], [0, 2, 4, 6, 7] ) == 0,
    "Test case 2";

ok disjoint( [2], [0, 2, 4, 6, 7] ) == 0,
    "Test case 3";
