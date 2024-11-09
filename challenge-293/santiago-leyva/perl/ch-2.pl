=begin
You are given an array of points, (x, y).

Write a script to find out if the given points are a boomerang.

A boomerang is a set of three points that are all distinct and not in a straight line.

Example 1
Input: @points = ( [1, 1], [2, 3], [3,2] )
Output: true
Example 2
Input: @points = ( [1, 1], [2, 2], [3, 3] )
Output: false
Example 3
Input: @points = ( [1, 1], [1, 2], [2, 3] )
Output: true
Example 4
Input: @points = ( [1, 1], [1, 2], [1, 3] )
Output: false
Example 5
Input: @points = ( [1, 1], [2, 1], [3, 1] )
Output: false
Example 6
Input: @points = ( [0, 0], [2, 3], [4, 5] )
Output: true

=cut

use strict;
use warnings;
use Data::Dumper;
#use Test::More tests => 2;

my @tests = ([( [1, 1], [2, 3], [3,2] )], #1 true
             [( [1, 1], [2, 2], [3, 3] )], #2 false
             [( [1, 1], [1, 2], [2, 3] )], #3 true
             [( [1, 1], [1, 2], [1, 3] )], #4 false
             [( [1, 1], [2, 1], [3, 1] )], #5 false
             [( [0, 0], [2, 3], [4, 5] )]); #6 true

foreach(@tests){
    my @input = @$_;
    my $result = isBoomerang(\@input);
    print "$result\n";
}

sub isBoomerang {
    my $arr = shift;
    my @A = @$arr;
    my ($sum_pos1,$sum_pos2) = 0;

    for(my $i=2;$i<(scalar @A);$i++){ #starting from position 2 since two initial points always on the same line

        my $x1 = $A[0][0]; 
        my $y1 = $A[0][1]; 

        my $x2 = $A[1][0]; 
        my $y2 = $A[1][1]; 

        my $xi = $A[$i][0];
        my $yi = $A[$i][1];  

        if($x1 == $x2){
            if($xi != $x1){
                return "true";
            }
        }
        #Same k in y = k * x + b
        if (!(($y1 - $y2) * ($xi - $x2) == ($yi - $y2) * ($x1 - $x2))){
            return "true";
        }
        #Same b in y = k * x + b
        if (!(($y2 * $x1 - $y1 * $x2) * ($xi - $x2) == ($y2 * $xi - $yi * $x2) * ($x1 - $x2))){
            return "true";
        }
    }

    return "false";
}