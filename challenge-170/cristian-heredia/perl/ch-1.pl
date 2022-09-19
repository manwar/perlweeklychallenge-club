=begin

    Write a script to generate first 10 Primorial Numbers.

    Primorial numbers are those formed by multiplying successive prime numbers.

    For example,

        P(0) = 1    (1)
        P(1) = 2    (1x2)
        P(2) = 6    (1x2×3)
        P(3) = 30   (1x2×3×5)
        P(4) = 210  (1x2×3×5×7)

=end
=cut

use strict;
use warnings;
use Data::Dumper;

my $max = 10;
my $valor = 1;

my @primes = primeNumbers();
primorialNumbers();

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
    unshift(@primes, "1");
    return @primes;
}

sub primorialNumbers{
    foreach(my $j=0; $j<=$max-1; $j++){
       $valor = $valor*$primes[$j];
       print "P($j) = $valor\n";
    }
}


