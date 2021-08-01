use strict;
use warnings;
##
#    
##
use boolean;  
use Math::GSL::Vector;

use Data::Dump q/pp/; 

sub unique{
    my %seen;
    return grep {!$seen{$_}++} @_;
} 

sub is_square{
    my @points = @_;
    ##
    # Definitely a square if there are only 2 x and 2 y values. 
    ##
    my @x = unique(map {$_->[0]} @points);  
    my @y = unique(map {$_->[1]} @points);  
    return true if @x == 2 && @y == 2;
    ##
    # sort the points and compute side lengths  
    ##  
    my @sorted_x = sort {$a->[0] <=> $b->[0]} @points;  
    my @sorted_y = sort {$a->[1] <=> $b->[1]} @points;  
    my($s, $t, $u, $v) = ($sorted_y[@sorted_y - 1], $sorted_x[@sorted_x - 1], $sorted_y[0], $sorted_x[0]);    
    return false if $s->[0] + $u->[0] != $t->[0] + $v->[0];  
    return false if $s->[1] + $u->[1] != $t->[1] + $v->[1];  
    return false if $s->[1] - $u->[1] != $t->[0] - $v->[0];  
    ##
    # compute angles 
    ##
    my $dv_st = new Math::GSL::Vector([$s->[0] - $t->[0], $s->[1] - $t->[1]]); 
    my $dv_tu = new Math::GSL::Vector([$t->[0] - $u->[0], $t->[1] - $u->[1]]); 
    my $dv_uv = new Math::GSL::Vector([$u->[0] - $v->[0], $u->[1] - $v->[1]]); 
    my $dv_vs = new Math::GSL::Vector([$v->[0] - $s->[0], $v->[1] - $s->[1]]); 
    return false if $dv_st * $dv_tu != 0;
    return false if $dv_tu * $dv_uv != 0;
    return false if $dv_uv * $dv_vs != 0;
    return true;  
}



MAIN:{
    my @points;
    @points = ([10, 20], [20, 20], [20, 10], [10, 10]);  
    print is_square(@points) . "\n";  
    @points = ([12, 24], [16, 10], [20, 12], [18, 16]);  
    print is_square(@points) . "\n";  
    @points = ([-3, 1], [4, 2], [9, -3], [2, -4]);  
    print is_square(@points) . "\n";  
    @points = ([0, 0], [2, 1], [3, -1], [1, -2]);  
    print is_square(@points) . "\n";  
}
