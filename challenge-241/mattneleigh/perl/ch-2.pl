#!/usr/bin/perl

use strict;
use warnings;
use English;
use List::Util qw(max);

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 11, 8, 27, 4 ]
);

# 3: Get a prime number table for the largest value
# we'll deal with in the entre problem set
my $primes = sieve_of_eratosthenes(
    # 2: Get the max from the list of maxes
    max(
        # 1: Get a list of the max values from each list
        map(
            max(@{$_}),
            @integer_lists
        )
    )
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@int = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", sort_by_prime_factor_count($primes, @{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of unique positive integers greater than 2, sort them in
# ascending order by the count of their prime factors, or by their value if
# prime factor counts are equal
# Takes two arguments:
# * A ref to a string that represents a table of prime numbers at least as
#   large as the largest value in the list to be sorted (see documentation for
#   sieve_of_eratosthenes() below for the format of this string)
# * A list of unique positive integers greater than 2
# Returns:
# * The integers, sorted in ascending order according to the criteria mentioned
#   above
################################################################################
sub sort_by_prime_factor_count{
    my $primes = shift();

    return(
        # 3: Make a list of the original values from
        # the now-sorted pairs
        map(
            $_->[0],
            # 2: Sort; if prime factor counts are equal,
            # order the pairs by their original value,
            # otherwise order them by their prime factor
            # count
            sort(
                {
                    ($a->[1] == $b->[1]) ?
                        ($a->[0] <=> $b->[0])
                        :
                        ($a->[1] <=> $b->[1])
                }
                # 1: Make a list containing the original numbers
                # paired with the counts of their prime factors
                map(
                    [ $_, count_prime_factors($primes, $_) ],
                    @ARG
                )
            )
        )
    );

}



################################################################################
# Determine how many prime factors a given integer has
# Takes two arguments:
# * A ref to a string that represents a table of prime numbers at least as
#   large as N (see documentation for sieve_of_eratosthenes() below for the
#   format of this string)
# * The integer N to examine (e.g. 50)
# Returns:
# * The number of prime factors the number N has (e.g. 3)
################################################################################
sub count_prime_factors{
    use POSIX;

    my $primes = shift();
    my $n = int(shift());

    my $count = 0;

    # Loop until $n is prime
    until(substr(${$primes}, $n, 1)){
        # $n is not prime; set an upper bound on
        # our factor search
        my $i;
        my $max = ceil(sqrt($n));

        # Loop until we find prime $i that
        # divides evenly into $n
        for($i=2; $i<=$max; $i++){
            next unless(substr(${$primes}, $i, 1));
            last unless($n % $i);
        }

        # Increment the count and divide $n by $i
        $count++;
        $n /= $i;

    }

    # By now $n would hold the last prime factor
    # of the originally-supplied argument; return
    # the current count plus one
    return($count + 1);

}



################################################################################
# Use the Sieve of Eratosthenes to find a quantity of prime numbers
# Takes one required argument and one optional argument:
# * A positive integer N (e.g. 20)
# Returns on success:
# * A ref to a string of ones and zeros representing a table of prime and
#   non-prime numbers, respectively, from 0 to N, inclusive (e.g.
#   $$ref == "001101010001010001010"); this is used instead of an array as it
#   will take up far less memory
# Returns on error:
# * undef if N is not a positive integer
################################################################################
sub sieve_of_eratosthenes{
    use POSIX;

    my $n = int(shift());

    return(undef)
        unless($n > 0);

    my $max = floor(sqrt($n));
    my $i;
    my $j;
    my $k;
    my $table;

    # Initialize the table to contain
    # (mostly...) true values
    $table = "00" . "1" x ($n - 1);

    # Loop over $i not exceeding the square
    # root of $n
    for($i = 2; $i <= $max; $i++){
        # If the $i'th cell is true, we haven't
        # examined the multiples of $i yet
        if(substr($table, $i, 1)){
            $k = 0;
            # Assignment in expression is deliberate
            while(($j = $i ** 2 + $k++ * $i) <= $n){
                # $j is not prime; set its cell in the
                # table to false
                substr($table, $j, 1) = "0";
            }
        }
    }

    # Hand a ref to the completed table
    # back to the caller
    return(\$table);

}



