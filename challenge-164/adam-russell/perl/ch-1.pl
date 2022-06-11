use strict;
use warnings;
##
# Write a script to find all prime numbers less than 1000, which
# are also palindromes in base 10.
##
use Math::Primality qw/is_prime/;

sub palindrome_primes_under{
    my($n) = shift;
    my @palindrome_primes;
    {
        $n--;
        unshift @palindrome_primes, $n if(is_prime($n) && join("", reverse(split(//, $n))) == $n);
        redo if $n > 1;  
    }
    return @palindrome_primes;
}


MAIN:{
    print join(", ", palindrome_primes_under(1000));
}
