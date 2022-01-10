#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @numbers = (
    # Given case
    10001,

    # Additional test cases
#    1, 2, 3, 4, 5, 6, 7,

    # If you're a glutton for punishment...
#    1000000,
#    5000000,
#    10000000,
#    50000000,
#    100000000,
#    150000000,
#    1000000000,
);
my $n;

foreach $n (@numbers){
    printf(
        "The n'th prime number, where n = %d, is: %d\n\n",
        $n,
        calculate_nth_prime($n)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the Nth prime number
# Takes one argument:
# * A positive integer N (e.g. 5)
# Returns on success:
# * The Nth prime number (e.g. 11)
# Returns on error:
# * undef if N is not a positive integer, or if, for some reason, the upper
#   bound for the approximate value of the Nth prime was not large enough to
#   calculate the correct value
# Approximation of the upper bound provided by:
# https://en.wikipedia.org/wiki/Prime_number_theorem
################################################################################
sub calculate_nth_prime{
    use POSIX;

    my $n = int(shift());

    return(undef)
        if($n < 1);

    if($n > 6){
        # Use an upper bound for the approximate
        # value of the $nth prime, and request
        # the raw table of primes; this
        # approximation holds only if $n > 6
        my $primes = sieve_of_eratosthenes(
            ceil($n * (log($n) + log(log($n)))),
            1
        );
        my $l = length($$primes);
        my $i = 2;
        my $ct = 0;

        while($i < $l){
            $ct++ if(substr($$primes, $i, 1) eq "1");
            last if($ct == $n);
            $i++;
        }

        if($i == $l){
            # This should only happen if we didn't
            # generate enough primes...
            return(undef);

        } else{

            return($i);

        }

    } else{
        # Just grab the entire set of the first
        # six primes
        my @primes = sieve_of_eratosthenes(13);

        return($primes[$n - 1]);

    }

}



################################################################################
# Use the Sieve of Eratosthenes to find a quantity of prime numbers
# Takes one required argument and one optional argument:
# * A positive integer N (e.g. 20)
# * An optional value that, if present and evaluates as true, will instruct
#   this function to return a stringified table of prime and non-prime values
#   (see below)
# Returns on success:
# * A list of all prime numbers less than or equal to N (e.g. (2, 3, 5, 7, 11,
#   13, 17, 19)) if the second argument is missing or false
# -- OR --
# * A ref to a string of ones and zeros representing a table of prime and
#   non-prime numbers, respectively, from 0 to N, inclusive (e.g.
#   $$ref == "001101010001010001010") if the second argument is present and
#   true; this is used internally for sieving primes, and it may be of use to
#   the caller if N is large, as it will take up far less memory than an array
#   of the actual values
# Returns on error:
# * undef if N is not a positive integer
################################################################################
sub sieve_of_eratosthenes{
    use POSIX;

    my $n = int(shift());
    my $return_table = shift();

    return(undef)
        unless($n > 0);

    my $max = floor(sqrt($n));
    my $i;
    my $j;
    my $k;
    my $table;
    my @primes;

    # Initialize the table to contain
    # (mostly...) true values
    $table = "00" . "1" x ($n - 1);

    # Loop over $i not exceeding the square
    # root of $n
    for($i = 2; $i <= $max; $i++){
        # If the $i'th cell is true, we haven't
        # examined the multiples of $i yet
        if(substr($table, $i, 1) eq "1"){
            $k = 0;
            # Assignment in expression is deliberate
            while(($j = $i ** 2 + $k++ * $i) <= $n){
                # $j is not prime; set its cell in the
                # table to false
                substr($table, $j, 1) = "0";
            }
        }
    }

    if($return_table){
        # Hand a ref to the completed table
        # back to the caller
        return(\$table);

    } else{
        # Build a list of indices for which
        # the corresponding members of the
        # table are true
        for($i = 2; $i <= $n; $i++){
            push(@primes, $i)
                if(substr($table, $i, 1) eq "1");
        }

        return(@primes);

    }

}



