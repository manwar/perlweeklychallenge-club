use strict;
use warnings; 
##
# You are given a list of numbers. Write a script to calculate
# the sum of the bitwise & operator for all unique pairs.  
##
sub sum_bitwise{
    my $sum = 0;
    for my $i (0 .. @_ - 2){
        my $x = $_[$i];
	map {$sum += ($x & $_)} @_[$i + 1 .. @_ - 1];
    }
    return $sum; 
}

MAIN:{
    print sum_bitwise(1, 2, 3) . "\n";  
    print sum_bitwise(2, 3, 4) . "\n";
}  
