#!/usr/bin/perl
# The Weekly Challenge 123
# Task 2 Square Points
# Usage: ch-2.pl (optional)$D
# Then input the coordinates of the points 
# $D: 2 or above, either the plane or space, default is 2

use strict;
use warnings;
use v5.10.0;
use Test::More tests => 13; 

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
    # "dot product test";
    # return 0 unless (vec_prod_f($v1, $v2) == 0) xor
    #                (vec_prod_f($v0, $v2) == 0) xor
    #                (vec_prod_f($v0, $v1) == 0);
    my @n_vector = map { norm($_) } ($v0, $v1, $v2);
    @n_vector = sort {$a<=>$b} @n_vector;
    # "norm test"
    #if ( $n_vector[0] == $n_vector[1] ) {
#   the above conditional is fit for integter coordinates
#   the below is special arrangement starting from the 5th test case 
#   or floating point number in general
    if ( sprintf("%f",$n_vector[0]) == sprintf("%f", $n_vector[1]) 
       && 2*sprintf("%f", $n_vector[0]) == sprintf("%f", $n_vector[2])
#       the above line concerning length of diagonal is sqrt(2)
#       times the edge length would not be a necessary check 
#       if we preserve the dot product test, because in
#       Euclidean space, if two vectors are orthogonal and in equal length,
#       we can apply the Pythagorean theorem.
         ) { 
        return 1;
    } 
    return 0;
}

sub vec_prod {
    my $first = $_[0];
    my $second = $_[1];
    warn "Not the same dimension in vec_prod \n" if $first->$#* != $second->$#*;
    my $sum = 0;
    $sum+= ($first->[$_]*$second->[$_]) for (0..$first->$#*);
    return $sum;
}

sub vec_prod_f {
    return sprintf("%f", vec_prod($_[0], $_[1]));
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
    warn "Not the same dimension in vec_sum \n" if $first->$#* != $second->$#*;
    for my $s (0..$first->$#*) {
        push $ans->@*, $first->[$s] + $second->[$s];
    }
    return $ans;
}

sub vec_same {
    my $first = $_[0];
    my $second = $_[1];
    warn "Not the same dimension in vec_same \n" if $first->$#* != $second->$#*;
    for my $s (0..$first->$#*) {
        return 0 if $first->[$s] != $second->[$s];
    }
    return 1;
}

sub vec_subtract {
    my $first = $_[0];
    my $second = $_[1];
    my $ans = [];
    warn "Not the same dimension in vec_subtract\n" if $first->$#* != $second->$#*;
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

ok is_square( [5/sqrt(26), 1/sqrt(26)], 
              [-1/sqrt(26), 5/sqrt(26)],
              [-5/sqrt(26), -1/sqrt(26)], 
              [1/sqrt(26), -5/sqrt(26)]) == 1,
             "inclined by arctan(1/5), centre at origin"; 

ok is_square( 
              [cos(atan2(1,5)), sin(atan2(1,5))], 
              [-sin(atan2(1,5)), cos(atan2(1,5))],
              [-cos(atan2(1,5)), -sin(atan2(1,5))],
              [sin(atan2(1,5)), -cos(atan2(1,5))]
            )  
              == 1, "arctan(1/5) by atan2(), caught by the equalities";  

ok is_square( 
              [2.7*cos(atan2(1,5)), 2.7*sin(atan2(1,5))], 
              [-2.7*sin(atan2(1,5)), 2.7*cos(atan2(1,5))],
              [-2.7*cos(atan2(1,5)), -2.7*sin(atan2(1,5))],
              [2.7*sin(atan2(1,5)), -2.7*cos(atan2(1,5))]
            )  
              == 1, 
             "arctan(1/5) by atan2() of larger size (multipled by 2.7), "
            ."caught by the equalities";  

ok is_square( 
              [2.8*cos(atan2(1,5)), 2.8*sin(atan2(1,5))], 
              [-2.8*sin(atan2(1,5)), 2.8*cos(atan2(1,5))],
              [-2.8*cos(atan2(1,5)), -2.8*sin(atan2(1,5))],
              [2.8*sin(atan2(1,5)), -2.8*cos(atan2(1,5))]
            )  
              == 1, 
             "arctan(1/5) by atan2() of larger size (multipled by 2.8), "
            ."caught by the equalities";  

ok is_square( 
              [4.0*cos(atan2(1,5)), 4.0*sin(atan2(1,5))], 
              [-4.0*sin(atan2(1,5)), 4.0*cos(atan2(1,5))],
              [-4.0*cos(atan2(1,5)), -4.0*sin(atan2(1,5))],
              [4.0*sin(atan2(1,5)), -4.0*cos(atan2(1,5))]
            )  
              == 1, 
             "arctan(1/5) by atan2() of larger size (multipled by 4.0)"
            .", caught by the equalities";
ok is_square( 
              [0.0009*cos(atan2(1,5)), 0.0009*sin(atan2(1,5))], 
              [-0.0009*sin(atan2(1,5)), 0.0009*cos(atan2(1,5))],
              [-0.0009*cos(atan2(1,5)), -0.0009*sin(atan2(1,5))],
              [0.0009*sin(atan2(1,5)), -0.0009*cos(atan2(1,5))]
            )  
              == 1, 
             "arctan(1/5) by atan2() of a much smaller size"
            ." (multiple by 0.0009), caught by the equalities"
            ." (expected fail)";  
;


ok is_square( 
            [-2, 2*sqrt(3), -2*sqrt(3)-1 ],  
            [-2, 4+2*sqrt(3), -1+2*sqrt(3) ], 
            [ 6, 2*sqrt(3), -2*sqrt(3)-1],
            [ 6, 4+2*sqrt(3), -1+2*sqrt(3)]
        );

ok is_square( 
            [ 6, -2*sqrt(3), 3-2*sqrt(3)],
            [-2, -2*sqrt(3), 3-2*sqrt(3)],  
            [-2, 4-2*sqrt(3), 3+2*sqrt(3)],    
            [ 6, 4-2*sqrt(3), 3+2*sqrt(3)],
        );
done_testing();
