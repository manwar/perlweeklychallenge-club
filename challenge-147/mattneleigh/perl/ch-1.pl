#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $n = 20;
my @trunc_primes = calculate_left_truncatable_primes(20, 0);

printf(
    "\nThe first %d left-truncatable primes are: %s\n\n",
    scalar(@trunc_primes),
    join(", ", @trunc_primes)
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the first N left-truncatable prime numbers (see
# https://en.wikipedia.org/wiki/Truncatable_prime )
# Takes two arguments:
# * The number N of left truncatable prime numbers desired
# * The maximum number to examine when calculating primes to evaluate for left-
#   truncatability; if this argument is undefined or less than one, a default
#   of 1000 will be used
# Returns on success:
# * A list of left-truncatable primes 
#   NOTE: If the maximum value to search (see arguments above) is too small to
#   produce N left-truncatable primes, the list will have fewer than N members
# Returns on error:
# * undef if N is less than 1
################################################################################
sub calculate_left_truncatable_primes{
    my $n = int(shift());
    my $max = int(shift());

    return(undef)
        if($n < 1);

    if(!defined($max) || ($max < 1)){
        $max = 1000;
    }

    my $primes = sieve_of_eratosthenes($max, 1);
    my $i = 2;
    my @trunc_primes;

    while((scalar(@trunc_primes) < $n) && ($i <= $max)){
        my $numstr = $i;

        unless($numstr =~ m/0/){
            # The number doesn't contain zero...

            # loop while $numstr is nonzero
            # length and is prime
            while(length($numstr) && (substr($$primes, $numstr, 1) eq "1")){
                if(length($numstr) == 1){
                    # Got down to one digit and it's
                    # prime; $i was a left-truncable
                    # prime
                    push(@trunc_primes, $i);
                }

                # Trim the string
                $numstr = substr($numstr, 1);
            }
        }

        $i++;
    }

    return(@trunc_primes);

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



