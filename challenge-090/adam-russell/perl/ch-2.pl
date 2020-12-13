use strict;
use warnings;
##
# You are given two positive numbers $A and $B.
# Write a script to demonstrate Ethiopian Multiplication 
# using the given numbers.
##
sub ethiopian_multiplication{
    my($a, $b) = @_;
    my @steps;
    my ($x, $y) = ($a, $b); 
    do{
        $x = int($x / 2);
        $y = $y * 2;
print "$x $y\n"; 
        push @steps, [$x, $y];
    }until $steps[-1]->[0] == 1 || $steps[-1]->[1] == 1; 
}

MAIN:{
    my($A, $B) = (14, 12);
    ethiopian_multiplication($A, $B);
}
