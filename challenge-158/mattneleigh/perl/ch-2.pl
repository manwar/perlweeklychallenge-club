#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $n = 1000;

printf(
    "\nThe cuban prime numbers less than or equal to %d are:\n    %s\n\n",
    $n,
    join(", ", calculate_cuban_primes($n))
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the cuban prime numbers- prime numbers that are the difference of
# two consecutive cubes- that are less than or equal to a number N, which must
# be at least 2
# Takes one argument:
# * The number N, which must be greater than or equal to 2
# Returns on success:
# * A list of cuban prime numbers
# Returns on error:
# * undef if N is not at least 2
################################################################################
sub calculate_cuban_primes{
    my $n = int(shift());

    return(undef)
        unless($n > 1);

    # Generate a table of primes sufficient
    # for our purposes
    my $prime_table = ${sieve_of_eratosthenes($n, 1)};
    my $k = 1;
    my @cubans;

    while(1){
        # Calculate a prospective cuban prime
        # number; see https://oeis.org/A002407
        # and note the comment added on Nov 28,
        # 2007
        my $p = 1 + 3 * $k * ++$k;

        # Break out of the loop if $p has
        # exceeded $n
        last
            if($p > $n);

        # Skip values of $p that aren't prime
        next
            unless(substr($prime_table, $p, 1));

        # $p is a cuban prime and is not larger
        # than $n; store it
        push(@cubans, $p);

    }

    # Return the list of cuban primes
    return(@cubans);

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



