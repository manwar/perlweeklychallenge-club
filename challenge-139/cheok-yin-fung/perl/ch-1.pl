#!/usr/bin/perl
# The Weekly Challenge 139
# Task 1: JortSort
# Usage: $ ch-1.pl [@n]
use v5.12.0;
use warnings;
use Test::More tests => 5;

die "Input error.\n" if !defined([@ARGV]) || $#ARGV == 0;

say jortsort(@ARGV) if defined($ARGV[0]);

sub jortsort {
    my @n = @_;
    my $bool;
    my $inc = ($n[0] <= $n[1]);

    for (1..$#n) {
        $bool = $n[$_-1] == $n[$_] || $inc == ($n[$_-1] < $n[$_]);
        unless ($bool) {
            if ($n[$_-1]==$n[0]) {
                $inc = !$inc;
                $bool = 1;
            }
            else {
                last;
            }
        }
    }
    return $bool ? 1 : 0;
}

ok jortsort(1,2,3,4,5) == 1, "Test Case 1,2,3,4,5";
ok jortsort(5,4,3,2,1) == 1, "Test Case reverse 1,2,3,4,5";
ok jortsort(5,3,3,2,1) == 1, "Test Case 5,3,3,2,1";
ok jortsort(1,1,1,1,1) == 1, "Test Case 1,1,1,1,1";
ok jortsort(9,10,9,8,7) == 0, "Test Case Negative";
