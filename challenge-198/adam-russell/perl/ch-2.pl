use v5.36;
##
# You are given an integer $n > 0.
# Write a script to print the count of primes less than $n.
##
use Math::Primality q/is_prime/;

sub prime_count{
    return 0 + grep { is_prime $_ } 2 .. $_[0] - 1;  
}


MAIN:{
    say prime_count(10);  
    say prime_count(15);  
    say prime_count(1);  
    say prime_count(25);  
}
