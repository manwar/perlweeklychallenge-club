#!/usr/bin/perl
# The Weekly Challenge 123
# Task 2 Square Points
# Usage: ch-2.pl (optional)$D
# Then input the coordinates of the points 
# $D: 2 or above, either the plane or space, default is 2

use strict;
use warnings;
use v5.10.0;
use Test::More tests => 5; 

my $D = $ARGV[0] || 2;

my $pt0 = [split " ", <STDIN>];
my $pt1 = [split " ", <STDIN>];
my $pt2 = [split " ", <STDIN>];
my $pt3 = [split " ", <STDIN>];

say is_square($pt0, $pt1, $pt2, $pt3);


sub is_square {
    my ($p0,$p1,$p2,$p3) = ($_[0], $_[1], $_[2], $_[3]);
    my $v0 = vec_subtract($p0, $p1);
    my $v1 = vec_subtract($p0, $p2);
    my $v2 = vec_subtract($p0, $p3);
    # "cross product test";
    return 0 unless (vec_prod($v1, $v2) == 0) xor
                    (vec_prod($v0, $v2) == 0) xor
                    (vec_prod($v0, $v1) == 0);
    # "vector sum test";
    return 0 unless vec_same($v0, vec_sum($v1, $v2) ) xor
                    vec_same($v1, vec_sum($v2, $v0) ) xor
                    vec_same($v2, vec_sum($v0, $v1) );
    my @n_vector = map { norm($_) } ($v0, $v1, $v2);
    @n_vector = sort {$a<=>$b} @n_vector;
    # "norm test"
    #if ( $n_vector[0] == $n_vector[1] ) {
#   the above conditional is fit for integter coordinates
#   the  below is special arrangement for the 5th test case 
#   or floating point number in general
    if ( sprintf("%f",$n_vector[0]) eq sprintf("%f", $n_vector[1]) ) { 
        return 1;
    } 
    return 0;
}

sub vec_prod {
    my $first = $_[0];
    my $second = $_[1];
    die "Not the same dimension in vec_prod \n" if $first->$#* != $second->$#*;
    my $sum = 0;
    $sum+= ($first->[$_]*$second->[$_]) for (0..$first->$#*);
    return $sum;
}

sub norm {
    my $p = $_[0];
    my $sum = 0;
    $sum+= ($p->[$_])**2 for (0..$p->$#*);
    return $sum;
}

sub vec_sum {
    my $first = $_[0];
    my $second = $_[1];
    my $ans = [];
    die "Not the same dimension in vec_sum \n" if $first->$#* != $second->$#*;
    for my $s (0..$first->$#*) {
        push $ans->@*, $first->[$s] + $second->[$s];
    }
    return $ans;
}

sub vec_same {
    my $first = $_[0];
    my $second = $_[1];
    die "Not the same dimension in vec_same \n" if $first->$#* != $second->$#*;
    for my $s (0..$first->$#*) {
        return 0 if $first->[$s] != $second->[$s];
    }
    return 1;
}

sub vec_subtract {
    my $first = $_[0];
    my $second = $_[1];
    my $ans = [];
    die "Not the same dimension in vec_subtract\n" if $first->$#* != $second->$#*;
    for my $s (0..$first->$#*) {
        push $ans->@*, $second->[$s] - $first->[$s];
    }
    return $ans;
}


ok is_square( [10,20], [20,20], [20, 10], [10, 10] ) == 1, "Example 1";
ok is_square( [12,24], [16,10], [20, 12], [18, 16] ) == 0, "Example 2";
ok is_square( [1, 2] , [4,3], [3,1], [2,4] ) == 1, "Knight's square";
ok is_square( [1, 1] , [-1, 1], [ 1,-1], [-1,-1] ) == 1, "centre at origin";
ok is_square( [1, sqrt(3)/2, -1/2], [1, -sqrt(3)/2, 1/2], 
              [-1, sqrt(3)/2, -1/2], [-1, -sqrt(3)/2, 1/2] ) == 1, 
             "centre at origin, inclined";
done_testing();
