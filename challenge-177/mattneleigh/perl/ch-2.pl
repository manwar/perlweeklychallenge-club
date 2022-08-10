#!/usr/bin/perl

use strict;
use warnings;
use English;

use POSIX;

################################################################################
# Begin main execution
################################################################################

my $q = 20;
my $n = 0;
my @pal_cy_primes = ();

# Loop until we have enough numbers
until(scalar(@pal_cy_primes) == $q){
    my $candidate;

    # Increment $n
    $n++;

    # Skip any $n that has zero in it
    next
        if($n =~ m/0/);

    # If $n's first digit is even, add 1 to that
    # digit, skipping a series of otherwise-even
    # candidate numbers...
    $n += 10 ** floor(log($n) / log(10))
        unless(substr($n, 0, 1) % 2);

    # Construct a new candidate out of the digits
    # of $n and a zero...
    $candidate = $n . "0" . join('', reverse(split('', $n)));

    # Store this candidate if it's prime
    push(@pal_cy_primes, $candidate)
        if(is_prime($candidate));

}

printf(
    "\nThe first %d palindromic prime cyclops numbers are:\n\n%s\n\n",
    $q,
    join(", ", @pal_cy_primes)
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether a given integer N is prime
# Takes one argument:
# * The integer N
# Returns on success:
# * 1 if N is prime
# * 0 if N is not prime
# NOTE: If N is less than zero, it will always be considered nonprime
################################################################################
sub is_prime{
    my $n = int(shift());

    my $i;

    # Take care of a few easy cases
    return(1)
        if(($n == 2) || ($n == 3));
    return(0)
        if(($n <= 1) || !($n % 2) || !($n % 3));

    # See if certain factors divide evenly
    for($i = 5; $i * $i <= $n; $i += 6){
        if(!($n % $i) || !($n % ($i + 2))){
            return(0);
        }
    }

    return(1);

}



