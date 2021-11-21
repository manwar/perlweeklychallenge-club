#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $prime;
my @long_primes;

foreach $prime (sieve_of_eratosthenes(100)){
    push(@long_primes, $prime) if(is_long_prime($prime));
    last if(scalar(@long_primes) == 5);
}

print(
    "\nThe first five Long Primes are: ",
    join(", ", @long_primes),
    "\n\n"
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether a prime number is a "long prime" (full repetend prime)
# Takes one argument:
# * The prime number N to examine
# Returns:
# * 1 if N is a long prime
# * 0 if N is not a long prime
# NOTE: This function runs the external dc(1) program for arbitrary precision
# calculation
################################################################################
sub is_long_prime{
    my $n = shift();

    my $digits;

    # Get the required number of digits; I
    # could have installed an arbitrary
    # precision module for this calculation,
    # but I was lazy and dc(1) was just
    # sitting right there, soooo...
    $digits = ($n - 1) * 2;
    $digits = qx(echo "$digits k 1 $n / p" |dc);
    $digits =~ tr/.\\\n//d;

    if($digits =~ m/^(.*?)\1$/){
        # There is a patttern that repeats
        # twice...
        $digits = $1;
        if($digits !~ m/^(.*?)\1+$/){
            # ...and it does NOT have any repeating
            # sub-patterns within
            return(1);
        }
    }

    # Not a long prime
    return(0);

}



################################################################################
# Use the Sieve of Eratosthenes to find a quantity of prime numbers
# Takes one argument:
# * A number N (e.g. 20)
# Returns:
# * A list of all prime numbers less than or equal to N (e.g. (2, 3, 5, 7, 11,
#   13, 17, 19))
################################################################################
sub sieve_of_eratosthenes{
    use POSIX;

    my $n = shift();

    my $i;
    my $j;
    my $k;
    my @a = map(1, 0 .. $n);

    # Loop over $i not exceeding the square
    # root of $n
    for $i (2 .. floor(sqrt($n))){
        # If $a[$i] is true, we haven't
        # examined the multiples of $i yet
        if($a[$i]){
            $k = 0;
            # Assignment in expression is deliberate
            while(($j = $i ** 2 + $k++ * $i) <= $n){
                # $j is not prime; set its cell in @a to
                # false
                $a[$j] = 0;
            }
        }
    }

    # Return a list of indices for which
    # the corresponding members of @a are
    # true
    return(map($a[$_] ? $_ : (), 2 .. $n));

}



