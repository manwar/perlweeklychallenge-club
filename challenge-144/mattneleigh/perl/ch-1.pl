#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $n = 100;
my @semiprimes;
my $semiprime;

@semiprimes = find_semiprimes($n);

print("Semiprime numbers less than $n:\n");
if(1){
    # Short output
    printf("    %s\n", join(", ", map($_->{product}, @semiprimes)));
} else{
    # Long output
    foreach $semiprime (@semiprimes){
        printf(
            "%d is Semiprime as %d = %d x %d\n",
            $semiprime->{product},
            $semiprime->{product},
            $semiprime->{a},
            $semiprime->{b}
        );
    }
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find all semiprime numbers less than a specified value
# Takes one argument:
# * The maximum number N below which semiprime numbers will be calculated
# Returns:
# * A list of refs to hashes containing semiprime numbers less than the
#   specified value N, as well as the prime factors used to calculate each.
#   These data are stored within each hash using the following fields:
#
#   {
#       product => 77,    # The semiprime number calculated
#       a       => 7,     # The lesser (usually) prime factor
#       b       => 11     # The greater (usually) prime factor
#   }
#
################################################################################
sub find_semiprimes{
    use POSIX;

    my $n = shift();

    my @primes;
    my @semiprimes;
    my $i;
    my $j;

    # Gather a particular quantity of
    # prime numbers
    @primes = sieve_of_eratosthenes(ceil($n / 2));

    # Loop over the list of primes...
    for($i = 0; $i <= $#primes; $i++){
        # Loop over the list of primes
        # equal to or greater than the
        # $i'th prime...
        for($j = $i; $j <= $#primes; $j++){
            my $product = $primes[$i] * $primes[$j];

            if($product < $n){
                # The product of the $i'th and $j'th
                # primes is less than our target
                # number- store it
                push(
                    @semiprimes,
                    {
                        product => $product,
                        a       => $primes[$i],
                        b       => $primes[$j]
                    }
                );
            }
        } # End for $j
    } # End for $i

    # The product of the $i'th and $j'th
    # Sort the primes are in ascending order
    @semiprimes = sort({ $a->{product} <=> $b->{product} } @semiprimes);

    return(@semiprimes);

}



################################################################################
# Use the Sieve of Eratosthenes to find a quantity of prime numbers
# Takes one argument:
# * A number N (e.g. 20)
# Returns:
# * A list of all prime numbers less than or equal to N (e.g. (2, 3, 5, 7, 11,
#   13, 17, 19))
################################################################################
sub sieve_of_eratosthenes{
    use POSIX;

    my $n = shift();

    my $i;
    my $j;
    my $k;
    my @a = map(1, 0 .. $n);

    # Loop over $i not exceeding the square
    # root of $n
    for $i (2 .. floor(sqrt($n))){
        # If $a[$i] is true, we haven't
        # examined the multiples of $i yet
        if($a[$i]){
            $k = 0;
            # Assignment in expression is deliberate
            while(($j = $i ** 2 + $k++ * $i) <= $n){
                # $j is not prime; set its cell in @a to
                # false
                $a[$j] = 0;
            }
        }
    }

    # Return a list of indices for which
    # the corresponding members of @a are
    # true
    return(map($a[$_] ? $_ : (), 2 .. $n));

}



