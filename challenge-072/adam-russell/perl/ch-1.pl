use strict;
use warnings;
##
# You are given a positive integer $N (<= 10).
# Write a script to print the number of trailing zeroes in $N!.
##

sub factorial{
    my($n) = @_;
    return 1 if $n == 1; 
    return $n * factorial($n - 1); 
}

sub count_10s{
    my($n) = @_;
    return 2 if $n == 10;   
    return 1 if $n >=5 && $n < 10;   
    return 0 if $n < 5;   
} 

MAIN:{
    my $n = $ARGV[0]; 
    my $zeroes = count_10s($n);  
    print "\$N! = " . factorial($n) . " has $zeroes trailing zero\n" if $zeroes == 1; 
    print "\$N! = " . factorial($n) . " has $zeroes trailing zeroes\n" if $zeroes > 1 || $zeroes == 0; 
} 
