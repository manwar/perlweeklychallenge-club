#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @abundants;
my $quantity = 20;
my $n = 1;

while(scalar(@abundants) < $quantity){
    push(@abundants, $n)
        if(is_abundant_number($n));
    $n++;
}

print("\n");
print("The first ", $quantity, " abundant numbers are:\n");
print(join(", ", @abundants), "\n");
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether an integer is an abundant number (see
# https://en.wikipedia.org/wiki/Abundant_number for more information about this
# kind of number)
# Takes one argument:
# * The integer N to examine
# Returns:
# * 1 if N is an abundant number
# * 0 if N is not an abundant number
################################################################################
sub is_abundant_number{
    my $n = int(shift());

    # Set this to -$n to counteract $n itself
    # being in the factor list
    my $sum = -$n;

    # Use this hash approach to get unique
    # factors from factorize()
    my %factors = map(
        { $_ => 1 }
        factorize($n)
    );

    # Tally up the factors (we don't care
    # about their order)
    foreach(keys(%factors)){
        $sum += $_;
    }
    
    # If the sum is greater than $n, return 1;
    # otherwise return 0
    return(($sum > $n) ? 1 : 0);

}



################################################################################
# Calculate the factorization of an integer
# Takes one argument:
# * The integer N (e.g. 12)
# Returns:
# * A list of factors that multiply to N, in ascending order (e.g. (1, 2, 3, 4,
#   6, 12) )
# NOTE: The factor list will contain 1 and N itself, and may contain duplicate
# entries if N is a perfect square
################################################################################
sub factorize{
    use POSIX;

    my $n = int(shift());

    my $max = floor(sqrt($n));
    my @factors = ( 1 );
    my @quotients = ( $n );

    # No need to scan higher than the
    # square root of $n
    for my $i (2 .. $max){
        unless($n % $i){
            # $i divided evenly into $n...
            # Store $i as an integer factor
            push(@factors, $i);

            # Store the quotients in reverse
            # order (which will still be
            # ascending)
            unshift(@quotients, $n / $i);
        }
    }

    # Return these two lists as one
    return(@factors, @quotients);

}



