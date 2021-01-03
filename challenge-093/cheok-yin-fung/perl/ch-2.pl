#!/usr/bin/perl
# The Weekly Challenge 093
# Task 2 Sum Path
use strict;
use warnings;
use Data::Dumper;
use Test::More tests => 3;

sub jumptoLc {
    return $_[0] * 2 + 1;
}

sub jumptoRc {
    return $_[0] * 2 + 2;
}

sub sumpath {
    my @tree = @_;
    my $treelast = $#tree;
    
    my @path_val = @tree;
    my $final = 0;

    #BFS for binary tree represented as an array
    for (my $p = 1; $p <= $treelast; $p++) {
        if (defined($tree[$p])) {
            $path_val[$p] = $path_val[$p] + $path_val[int ($p-1)/2];
            if (!defined($tree[jumptoRc $p]) 
              &&
              !defined($tree[jumptoLc $p])) {
                $final+=$path_val[$p];
            }
        }
    }

    return $final;
}



ok (sumpath(30,1) == 31, "a segment");

ok (sumpath(1,2,undef, 3, 4) == 13, "Example 1");

ok (sumpath(1,2,3,4,undef, 5, 6) == 26, "Example 2");


