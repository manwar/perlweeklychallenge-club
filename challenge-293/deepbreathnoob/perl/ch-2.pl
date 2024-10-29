#!/usr/bin/perl
use strict;
use warnings;

my @points1 = ( [1, 1], [2, 3], [3,2] );
my @points2 = ( [1, 1], [2, 2], [3, 3] );
my @points3 = ( [1, 1], [1, 2], [2, 3] );
my @points4 = ( [1, 1], [1, 2], [1, 3] );
my @points5 = ( [1, 1], [2, 1], [3, 1] );
my @points6 = ( [0, 0], [2, 3], [4, 5] );

print "Input: ( [1, 1], [2, 3], [3,2] )\n";
print "Result: ".boomerang_chek(@points1)."\n";
print "Input: ( [1, 1], [2, 2], [3, 3] )\n";
print "Result: ".boomerang_chek(@points2)."\n";
print "Input: ( [1, 1], [1, 2], [2, 3] )\n";
print "Result: ".boomerang_chek(@points3)."\n";
print "Input: ( [1, 1], [1, 2], [1, 3] )\n";
print "Result: ".boomerang_chek(@points4)."\n";
print "Input: ( [1, 1], [2, 1], [3, 1] )\n";
print "Result: ".boomerang_chek(@points5)."\n";
print "Input: ( [0, 0], [2, 3], [4, 5] )\n";
print "Result: ".boomerang_chek(@points6)."\n";

sub boomerang_chek {
    my ($a, $b, $c) = @_;
    if(abs(($a->[0] * $b->[1] + $b->[0] * $c->[1] + $c->[0] * $a->[1] - $a->[1] * $b->[0] - $b->[1] * $c->[0] - $c->[1] * $a->[0]) / 2) > 0){
        return "True";
    }else {
        return "False";
    }
}