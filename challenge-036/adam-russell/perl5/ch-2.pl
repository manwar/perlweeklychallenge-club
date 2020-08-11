use strict;
use warnings;
##
# Write a program to solve the Knapsack Problem.
##
use Readonly;
Readonly::Array my @weights => (1, 1, 2, 12, 4); 
Readonly::Array my @values  => (1, 2, 2, 4, 10); 

sub knapsack{
    my($capacity, $n) = @_;
    return 0 if($n == 0 || $capacity == 0);
    return knapsack($capacity, $n - 1) if ($weights[$n - 1] > $capacity);
    my $a = knapsack($capacity - $weights[$n - 1], $n - 1) + $values[$n - 1];
    my $b = knapsack($capacity, $n - 1);   
    return $a > $b ? $a : $b; 
} 

MAIN:{
    my $max_capacity = 15; 
    print knapsack($max_capacity, scalar(@weights)); 
    print "\n"; 
} 
