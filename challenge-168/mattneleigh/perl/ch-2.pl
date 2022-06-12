#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $n = 10;

# If you have some time on your hands...
# $n = 8;

print("\n");
printf("HP(%d) = %d\n", $n, calculate_home_prime($n));
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the home prime of a given integer; see
# https://en.wikipedia.org/wiki/Home_prime for details about this type of
# number
# Takes one argument:
# * An integer N, which must be at least two (2)
# Returns on success:
# * The home prime of N
# Returns on error:
# * undef if N is less than two (2)
# NOTE: For certain values of N, this calculation can take wholly unreasonable
# amounts of time
################################################################################
sub calculate_home_prime{
    my $n = int(shift());

    return(undef)
        if($n < 2);

    # Loop until $n is prime
    until(is_prime($n)){
        my @factors;

        # Get the prime factors of $n, and concatenate
        # them into a new $n
        prime_factorize_number($n, \@factors);
        $n = join("", @factors);
    }

    return($n);

}



################################################################################
# Find the prime factorization of a given integer
# Takes two arguments:
# * The integer N to examine and factor
# * A ref to a list that will be populated with prime factors in ascending
#   order; any previous contents will be deleted
# Returns no meaningful value
################################################################################
sub prime_factorize_number{
    use POSIX;

    my $n = int(shift());
    my $factors = shift();

    # Clobber existing list contents if any
    splice(@{$factors}, 0)
        if(scalar(@{$factors}));

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



