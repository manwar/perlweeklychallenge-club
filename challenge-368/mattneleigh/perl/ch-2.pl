#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @numbers_and_parameters = (
    [ 100061, 0 ],
    [ 971088, 0 ],
    [ 63640,  1 ],
    [ 988841, 1 ],
    [ 211529, 0 ],
);

print("\n");
foreach my $number_and_paremeter (@numbers_and_parameters){
    printf(
        "Input: \$number = %d\n       \$mode = %d\nOutput: %d\n\n",
        $number_and_paremeter->[0],
        $number_and_paremeter->[1],
        calculate_omegas(@{$number_and_paremeter})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a positive integer and a mode, which must be zero (0) or one (1),
# calculate either the Little Omega (the count of all distinct prime factors)
# or the Big Omega (the count of all prime factors) of the provided integer
# Takes two arguments:
# * The number to examine (e.g. 63640)
# * A binary value that defines the mode of calculation to be employed with
#   zero (0) specifying that the Little Omega be calculated, and one (1)
#   specifying that the Big Omega be calculated
# Returns:
# * If the mode is 0, the Little Omega of the supplied number (e.g. 4)
# * If the mode is 1, the Big Omega of the supplied number (e.g. 6)
################################################################################
sub calculate_omegas{
    use List::MoreUtils qw(uniq);

    my $number = shift();
    my $mode = shift();

    my @prime_factors;

    # Get the prime factorization of the number
    prime_factorize($number, \@prime_factors);

    return(
        # Count the...
        scalar(
            $mode ?
                # ...prime factors
                @prime_factors
                :
                # ...distinct prime factors
                uniq(@prime_factors)
        )
    );

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
        return(0)
            unless(($n % $i) && ($n % ($i + 2)));
    }

    return(1);

}



