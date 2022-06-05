#!/usr/bin/perl

use strict;
use warnings;
use English;

use POSIX;

################################################################################
# Begin main execution
################################################################################

my %found_table;
my $order = 3;
my $primes = sieve_of_eratosthenes(10 ** $order);
my $n = 10 ** ($order - 1) - 1;
my @circulars;

# Loop until we've found ten circular primes
while(scalar(@circulars) < 10){
    my @sequence;

    $n++;

    if(ceil(log($n)/log(10)) >= $order){
        # Time to increase the order of magnitude and
        # wipe the table of found values (we'll be
        # dealing with a new number of digits now)
        $order++;

        # Yes, 10% of the new values are re-computed
        # from the previous iteration...
        $primes = sieve_of_eratosthenes(10 ** $order);
        %found_table = ();
    }

    # Skip $n if it's not prime
    unless(substr($$primes, $n, 1)){
        next;
    }
    # Skip $n if we've seen/generated it
    # before
    if($found_table{$n}){
        next;
    }

    @sequence = circular_character_sequence($n);

    # Build a list of 0's for each member of the sequence
    # that isn't prime; if the list is empty, $n is a
    # circular prime
    unless(map(substr($$primes, $_, 1) ? () : 0, @sequence)){
        # The prime was circular- store it, and put
        # all variations into the found table so we
        # can skip them later
        push(@circulars, $n);
        %found_table = (%found_table, map({ $_ => 1 } @sequence));        
    }

}

# Share what we've found
print("\n", join(", ", @circulars), "\n\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Generate a circular sequence of characters permuted from a given string
# Takes one argument:
# * The string to process (e.g. "1234")
# Returns:
# * A list of permuted strings (including the original), each rotated one
#   character position from the previous (e.g. ("1234", "2341", "3412",
#   "4123") )
################################################################################
sub circular_character_sequence{
    my $string = shift();

    my @strings;
    my @chars = split('', $string);

    push(@strings, $string);

    for(2 .. length($string)){
        push(@chars, shift(@chars));
        push(@strings, join('', @chars));        
    }

    return(@strings);

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



