#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $count = 8;

printf(
    "\nThe first %d unique Fortunate numbers are:\n    %s\n\n",
    $count,
    join(", ", calculate_fortunate_numbers($count))
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate a quantity of unique Fortunate numbers (see
# https://en.wikipedia.org/wiki/Fortunate_number )
# Takes one argument:
# * The number N of unique Fortunate numbers to calculate
# Returns on success:
# * A sorted list of the first N unique Fortunate numbers
# Returns on error:
# * undef if N is less than 1
################################################################################
sub calculate_fortunate_numbers{
    my $num = int(shift());

    return(undef)
        unless($num > 0);

    my %fortunate_ones = ();
    my $primorial = 1;
    my $next_prime = 2;

    # Loop until we've found enough unique
    # Fortunate numbers 
    while(scalar(keys(%fortunate_ones)) < $num){
        my $m = 1;

        # Calculate the next primorial and the
        # distance $m to the next prime such that
        # $m > 1; afterward, $m will be our
        # Fortunate number
        $primorial *= $next_prime;
        while(!is_prime($primorial + ++$m)){
            ;;
        }

        # Store the resulting $m as a key in a
        # hashtable, and calculate the next prime
        # for the next iteration
        $fortunate_ones{$m} = 1;
        while(!is_prime(++$next_prime)){
            ;;
        }
    }

    # Return a list sorted in numerical order
    return(sort({ $a <=> $b } keys(%fortunate_ones)));

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



