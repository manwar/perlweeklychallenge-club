#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $n = 20;

print("\n");
print(join(", ", calculate_brilliant_numbers($n)), "\n");
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate a specified quantity of the first brilliant numbers; see
# https://oeis.org/A078972 for information about this type of number
# Takes one argument:
# * The number N of brilliant numbers to calculate
# Returns on success:
# * A list of the smallest N brilliant numbers
# Returns on error:
# * undef if N is less than 1
################################################################################
sub calculate_brilliant_numbers{
    my $n = int(shift());

    return(undef)
        if($n < 1);

    my $i = 2;
    my @brilliants;

    # Loop until we have enough brilliant numbers
    while(scalar(@brilliants) < $n){
        my @factors;

        # Get the prime factors of $i
        prime_factorize($i, \@factors);

        # Store $i if it has two prime factors and they
        # are of the same length
        push(@brilliants, $i)
            if(
                (scalar(@factors) == 2)
                &&
                (length($factors[0]) == length($factors[1]))
            );

        # Increment $i
        $i++;
    }

    return(@brilliants);

}



################################################################################
# Find the prime factorization of a given integer
# Takes two arguments:
# * The integer N to examine and factor (e.g. 50)
# * A ref to a list that will be populated with prime factors in ascending
#   order (e.g. [ 2, 5, 5 ] ); any previous contents will be deleted
# Returns no meaningful value
################################################################################
sub prime_factorize{
    use POSIX;

    my $n = int(shift());
    my $factors = shift();

    # Clobber existing list contents if any
    @{$factors} = ();

    # Loop until $n is prime
    until(is_prime($n)){
        # $n is not prime; set an upper bound on
        # our factor search
        my $i;
        my $max = ceil(sqrt($n));

        # Loop until we find prime $i that
        # divides evenly into $n
        for($i=2; $i<=$max; $i++){
            next unless(is_prime($i));
            last unless($n % $i);
        }

        # Store the new prime factor $i and
        # divide $n by it
        push(@{$factors}, $i);
        $n /= $i;

    }

    # Store $n, which by now is the last prime
    # factor of the originally-supplied argument
    push(@{$factors}, $n);

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



