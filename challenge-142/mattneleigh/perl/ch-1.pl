#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @pairs = (
    [ 24,  2 ],
    [ 30,  5 ],
);
my $pair;

foreach $pair (@pairs){
    printf("Input: \$m = %d, \$n = %d\n", $pair->[0], $pair->[1]);
    printf("Output: %d\n\n", count_divisors_ending_in_n(@{$pair}));
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Count the divisors of a positive integer that end in a particular digit
# Takes two arguments:
# * The integer, M, to examine; if this number is not an integer, the
#   fractional portion will be truncated
# * The digit N to look for; if this number is more than 9, only the FIRST
#   digit will be searched for
# Returns on success:
# * The number of divisors of M that end in N
# Returns on error:
# * undef if either argument is not valid
# NOTE: Some definitions of the term "divisor" do not include the number M
# itself, while others do; the latter definition is adhered to in this
# function, thus if M ends in N, it will be counted
# https://en.wikipedia.org/wiki/Divisor#Examples
################################################################################
sub count_divisors_ending_in_n{
    my $m = abs(int(shift()));
    my $n = substr(abs(shift()), 0, 1);

    return(undef) unless(
        $m =~ m/^\d+$/ && $n =~ m/^\d+$/
    );

    my $i;
    my $factors = 0;

    # Loop until we get to the square root
    # of $m
    for($i = 1; $i * $i <= $m; $i++){
        my $quotient = $m / $i;

        # See if $i appears to divide evenly
        # into $m
        if(($quotient - int($quotient)) < 0.000001){
            # Increment the counter for each
            # factor that ends in $n
            $factors++ if($i =~ m/$n$/);
            $factors++ if(int($quotient) =~ m/$n$/);
        }
    }

    return($factors);

}



