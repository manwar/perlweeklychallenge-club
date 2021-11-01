#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @pairs = (
    [ 8, 24 ],
    [ 26, 39 ],
    [ 4, 10 ]
);
my $pair;

foreach $pair (@pairs){
    print("    Input: \$m = $pair->[0], \$n = $pair->[1]\n");
    print("    Output: ", two_friendly(@{$pair}), "\n\n\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine of two integers are Two Friendly (their Greatest Common Divisor is
# a Power of Two)
# Takes two arguments:
# * An integer M
# * An integer N
# Returns:
# * 1 if M and N are Two Friendly
# * 0 if M and N are NOT Two Friendly
################################################################################
sub two_friendly{
    my $m = int(shift());
    my $n = int(shift());

    my $power_two;

    # Compute the power of two of the greatest
    # common divisor
    $power_two = log(gcd($m, $n)) / log(2);

    # If $power_two looks like an integer
    # (accounting for round-off error...) then
    # the GCD of $m and $n was a power of two
    if(abs($power_two - int($power_two)) < 0.0000000001){
        return(1);
    } else{
        return(0);
    }

}



################################################################################
# Compute the Greatest Common Denominator (GCD) of two integers
# Takes two arguments:
# * An integer A
# * An integer B
# Returns:
# * The GCD of A and B
################################################################################
sub gcd{
    my $a = shift();
    my $b = shift();

    if($b){
        return(gcd($b, $a % $b));
    } else{
        return($a);
    }

}



