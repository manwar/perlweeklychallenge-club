#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $n = 20;
my $i = 1;
my @perfect_totients;

while(scalar(@perfect_totients) < $n){
    push(@perfect_totients, $i)
        if(is_perfect_totient($i));
    $i++;
}

printf(
    "\nThe first %d perfect totient numbers are:\n\n%s\n\n",
    $n,
    join(", ", @perfect_totients)
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether a positive integer N is a perfect totient number
# Takes one argument:
# * The positive integer N to examine
# Returns:
# * 1 if N is a perfect totient number
# * 0 if N is not a perfect totient number
# See https://en.wikipedia.org/wiki/Perfect_totient_number for more information
# about this type of number
################################################################################
sub is_perfect_totient{
    my $n = int(shift());

    my $totient = $n;
    my $totient_sum = 0;

    while($totient != 1){
        $totient = totient($totient);
        $totient_sum += $totient;
    }

    return(
        $totient_sum == $n ? 1 : 0
    );

}



################################################################################
# Calculate the number of positive integers that are relatively prime to a
# positive integer N by way of Euler's totient function
# Takes one argument:
# * The positive integer N to examine
# Returns:
# * The number of positive integers that are relatively prime to N
# See https://en.wikipedia.org/wiki/Euler%27s_totient_function for more
# information about this type of number
# NOTE: This function maintains a persistent store of computed totients so
# repeated calls on the same value will not require repeated calculations
################################################################################
sub totient{
    use v5.10;

    my $n = int(shift());

    # Special case: 1
    return(1)
        if($n == 1);

    # This will persist across calls
    state @totients;

    # No totient will be zero, so we can check for
    # undef (no totient) this way
    unless($totients[$n]){
        # We haven't seen this number before; calculate its
        # totient and store it
        my $totient = $n;
        my @prime_factors;

        prime_factorize_distinct($n, \@prime_factors);

        foreach my $factor (@prime_factors){
            $totient *= 1 - (1 / $factor);
        }

        # In case of round-off error...
        $totients[$n] = sprintf("%d", $totient) + 0;
    }

    return($totients[$n]);

}



################################################################################
# Find the distinct prime factors of a given positive integer N
# Takes two arguments:
# * The positive integer N to examine and factor (e.g. 50)
# * A ref to a list that will be populated with prime factors in ascending
#   order (e.g. [ 2, 5 ]; note that 5 would appear twice in a simple prime
#   factorization of 50); any previous contents will be deleted
# Returns no meaningful value
################################################################################
sub prime_factorize_distinct{
    use POSIX;

    my $n = int(shift());
    my $factors = shift();

    my $i = 2;

    # Clobber existing list contents if any
    @{$factors} = ();

    # Loop until $n is prime
    until(is_prime($n)){
        # $n is not prime; set an upper bound on
        # our factor search
        my $max = ceil(sqrt($n));

        # Loop until we find prime $i that
        # divides evenly into $n
        while($i <= $max){
            unless(is_prime($i)){
                $i++;
                next;
            }
            last unless($n % $i);
            $i++;
        }

        # Store the new prime factor $i if it is
        # distinct
        if(
            # Always store if the list is empty
            !scalar(@{$factors})
            ||
            ($i != $factors->[$#$factors])
        ){
            push(@{$factors}, $i);
        }

        # ...then divide $n by it
        $n /= $i;

    }

    # Store $n, which by now is the last prime
    # factor of the originally-supplied argument,
    # if it is distinct
    if(
        # Always store if the list is empty
        !scalar(@{$factors})
        ||
        ($n != $factors->[$#$factors])
    ){
        push(@{$factors}, $n);
    }

} 



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



