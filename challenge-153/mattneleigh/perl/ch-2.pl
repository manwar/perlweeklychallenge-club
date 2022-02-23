#!/usr/bin/perl

use strict;
use warnings;
use English;

# Need this for state variables
use v5.10;

################################################################################
# Begin main execution
################################################################################

my @numbers = (
    145,
    125
);
my $number;

foreach $number (@numbers){
    printf("\nInput: \$n = %d\nOutput: %d\n\n",
        $number,
        is_factorion($number)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether a number N is a Factorion (it is equal to the sum of its
# digits' factorials)
# Takes one argument:
# * The number N to examine
# Returns on success:
# * 1 if N is a Factorion
# * 0 if N is not a Factorion
# Returns on error:
# * undef if N is less than zero
################################################################################
sub is_factorion{
    my $n = int(shift());

    return(undef)
        if($n < 0);

    state @factorials;
    my $sum = 0;

    unless(@factorials){
        # Factorial list wasn't defined... generate
        # it; this only happens the first time this
        # function is called
        push(@factorials, 1);
        for(1 .. 9){
            push(@factorials, $factorials[$#factorials] * $ARG);
        }
    }

    # Split the number into digits and add up
    # the factorials of each digit
    foreach(split('', $n)){
        $sum += $factorials[$ARG];
    }
    
    return($sum == $n ? 1 : 0);

}



