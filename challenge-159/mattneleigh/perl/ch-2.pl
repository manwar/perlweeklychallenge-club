#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @numbers = ( 5, 10, 20 );
my $n;

print("\n");
foreach $n (@numbers){
    printf(
        "Input: \$n = %d\nOutput: %d\n\n",
        $n,
        calculate_moebius_number($n)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the Moebius number for a given integer N
# Takes one argument:
# * The integer N, which must be at least 1
# Returns on success:
# * The Moebius number for N, which will be 0 if N has a squared prime factor,
#   1 if N is square-free and has an even number of prime factors, and -1 if N
#   is square-free and has an odd number of prime factors
# Returns on error:
# * undef if N is less than 1
################################################################################
sub calculate_moebius_number{
    my $n = int(shift());

    return(undef)
        if($n < 1);

    # Special case, since 1 doesn't
    # prime-factorize well
    return(1)
        if($n == 1);

    my $primes = sieve_of_eratosthenes($n, 1);
    my %factors;

    # Shameless re-use of a function from PWC 150;
    # get the prime factorization and see if a
    # square was found
    if(_prime_factorize_number($n, $primes, \%factors)){
        # No square found; see if the number of factors
        # is even or odd
        if(scalar(keys(%factors)) % 2){
            # Odd
            return(-1);
        } else{
            # Even
            return(1);
        }
    } else{
        # A square was found
        return(0);
    }

}



################################################################################
# Find the prime factorization of a number via a recursive method
# Takes three arguments:
# * The number N to examine and factor
# * A ref to a string that acts as a table of prime numbers; see the
#   documentation for sieve_of_eratosthenes() for details
# * A ref to a hashtable that will be used to keep track of factors previously
#   seen; this must be empty upon the call to this function, but after it
#   returns, if the number had no squares in its factorization (see below) the
#   keys from this hash will make up the number's prime factorization 
# Returns:
# * 0 if a square was found during prime factorization
# * 1 if no square was found during prime factorization
# NOTE: This function should ONLY be called by calculate_moebius_number()
################################################################################
sub _prime_factorize_number{
    use POSIX;

    my $n = shift();
    my $primes = shift();
    my $factors = shift();

    my $i;
    my $max;

    if(substr($$primes, $n, 1)){
        # $n is prime
        if($factors->{$n}){
            # $n is a factor we've seen before
            return(0);
        } else{
            # $n is not a factor we've seen before
            $factors->{$n} = 1;
            return(1);
        }
    }

    # $n is not prime; set an upper bound on
    # our factor search
    $max = ceil(sqrt($n));

    # Loop until we find prime $i that
    # divides evenly into $n
    for($i=2; $i<=$max; $i++){
        next unless(substr($$primes, $i, 1));
        last unless($n % $i);
    }

    if($factors->{$i}){
        # $i is a factor we've seen before
        return(0);
    } else{
        # $i is not a factor we've seen before
        $factors->{$i} = 1;
        return(
            _prime_factorize_number(
                $n / $i,
                $primes,
                $factors
            )
        );
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



