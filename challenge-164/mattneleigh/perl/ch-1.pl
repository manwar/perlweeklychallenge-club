#!/usr/bin/perl

use strict;
use warnings;
use English;
use POSIX;

################################################################################
# Begin main execution
################################################################################

my $n = 1000;
my $output_pattern = "%".ceil(log($n)/log(10))."d";
my $rows;
my @palindromic_primes;

print("\n");
print("The palindromic primes less than $n are:\n\n");

# The problem specified less than 1000, not less than or
# equal to 1000...
@palindromic_primes = find_palindromic_primes($n - 1);

# Generate some moderately fancy output
$rows = ceil(scalar(@palindromic_primes) / 3);
for(0 .. ($rows - 1)){ 
    printf(
        "    %s    %s    %s\n",
        sprintf($output_pattern, $palindromic_primes[$_]),
        sprintf($output_pattern, $palindromic_primes[$rows + $_]),
        # This column might not be complete so check for
        # undef values and substitute an empty string if
        # we find one
        defined($palindromic_primes[$rows + $rows + $_])
            ?
            sprintf($output_pattern, $palindromic_primes[$rows + $rows + $_])
            :
            ""
    );
}

print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate paldindromic primes (prime numbers whose digits appear in the same
# order forward and backward) up to a specified value
# Takes one argument:
# * A number N; palindromic primes up to (and including) this number will be
#   found; this number must be at least 2
# Returns on success:
# * A list of palindromic primes
# Returns on error:
# * undef if N is not at least 2
################################################################################
sub find_palindromic_primes{
    my $primes = int(shift());

    return(undef)
        if($primes < 2);

    my @palindromic_primes = ();

    # Gather a quantity of prime numbers
    $primes = sieve_of_eratosthenes($primes);

    # Loop from 2 onward...
    for my $i (2 .. (length($$primes) - 1)){
        if(substr($$primes, $i, 1)){
            # $i is prime; see if it's a palindrome and
            # if so, store it in the list
            push(@palindromic_primes, $i)
                if(reverse(split("", $i)) == $i);
        }
    }

    return(@palindromic_primes);

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
    my $return_table = shift();

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



