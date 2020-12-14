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
    my $product = 0; 
    my ($x, $y) = ($a, $b); 
    do{
        $x = int($x / 2);
        $y = $y * 2;
        push @steps, [$x, $y] if $x % 2 != 0;
    }until $steps[-1]->[0] == 1; 
    for my $step (@steps){
        $product += $step->[1];
    } 
    return $product; 
}

MAIN:{
    my($A, $B) = (14, 12);
    print "$A x $B = " . ethiopian_multiplication($A, $B) . "\n";
}
