#!/usr/bin/perl

=pod
https://en.wikipedia.org/wiki/Bitwise_operation
 #Truth_table_for_all_binary_logical_operators

11 -> 11  3->3 | 1 1  
10 -> 01  2->1 | 0 1
01 -> 10  1->2 | 1 0
00 -> 00  0->0 | 0 0
pq               q p
=cut

# The Weekly Challenge - 120
# Task 1 Swap Odd/Even Bits
# Usage: $ ch-1.pl N 
use strict;
use warnings;
use Test::More tests => 4;

my $N = $ARGV[0];

sub qp {
    my $y = $_[0]; 
    my $a = int $y/2; 
    my $b = $y % 2; 
    return $b*2+$a;
}

sub soeb {
    my $x = $_[0];
    my @ans_arr;
    while ($x != 0) {
        unshift @ans_arr, qp($x % 4);
        $x = int $x / 4;
    }
    my $ans = 0;
    for (@ans_arr) {
        $ans <<= 2;
        $ans += $_;
    }
    return $ans;
}


print soeb($N), "\n";


ok (soeb(1) == 2, "N=1, output=2");
ok (soeb(101) == 154, "Example 1");
ok (soeb(18) == 33, "Example 2");
ok (soeb(128) == 64, "N=128, output=64");
