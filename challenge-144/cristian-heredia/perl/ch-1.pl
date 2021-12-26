=begin

    TASK #1 › Semiprime
    Submitted by: Mohammad S Anwar
    Write a script to generate all Semiprime number <= 100.

    For more information about Semiprime, please checkout the wikipedia page.


    In mathematics, a semiprime is a natural number that is the product of exactly two prime numbers. The two primes in the product may equal each other, so the semiprimes include the squares of prime numbers.


        Example
        10 is Semiprime as 10 = 2 x 5
        15 is Semiprime as 15 = 3 x 5

=end
=cut

use strict;
use warnings;
use Data::Dumper;


my @primes = primeNumbers();
my @result = semiprime();

# Print all the semiprimes numbers in a line, separated by ', '
print join(", ",@result);

# Function to obtain all the primes numbers <= 100
sub primeNumbers{
    foreach(my $i=2; $i<=100; $i++){
        push(@primes, $i);
        foreach(my $j=2; $j< $i; $j++){
            if ($i%$j == 0){
                pop(@primes);
                last;
            }
        }   
    }
    return @primes;
}

# Function to obtain all the semiprimes numbers <= 100
sub semiprime{
    foreach (my $l=2; $l<=100; $l++){
        foreach(my $m=0; $m<@primes; $m++){
            foreach(my $n=0; $n<@primes; $n++){
                if($l == ($primes[$m]*$primes[$n]) and not grep( /^$l$/, @result )){
                    push(@result, $l);
                }
            }
        }
    }
    return @result;
}