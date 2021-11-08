#!/usr/bin/perl
# The Weekly Challenge - 119
# Task 2 Sequence without 1-on-1
# Usage: $ ch-2.pl N 
use strict;
use warnings;
use Test::More tests => 3;

my $N = $ARGV[0] || 0;
print noo($N), "\n";

sub noo {
    my $p = $_[0];
    my @arr = (0,1,2,3);

    my $x = 0, my $y;

    while ($#arr < $p) {
        $y = $#arr;
        for my $here ($x+1..$y) {
            push @arr, $arr[$here]."1" 
                if substr($arr[$here], -1, 1) ne "1";
            push @arr, $arr[$here]."2";
            push @arr, $arr[$here]."3";
        }
        $x = $y;
    }
    return $arr[$p];
}

ok (noo(5) == 13, "Example 1");
ok (noo(10) == 32, "Example 2");
ok (noo(60) == 2223, "Example 3");
