#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $q = 19;
my $n = 0;
my @disariums;

while(scalar(@disariums) < $q){
# print("Checking ", $n, "... found ", scalar(@disariums), "\n");
    push(@disariums, $n)
        if(is_disarium_number($n));
    $n++;
}

printf(
    "\nThe first %d Disarium numbers are:\n    %s\n\n",
    $q,
    join(", ", @disariums)
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether an integer N is a Disarium number- the sum of each digit
# raised to the power of its position within the number is equal to the number
# itself (e.g. 518 == (5 ** 1) + (1 ** 2) + (8 ** 3) )
# Takes one argument:
# * The integer to examine
# Returns:
# * 1 if N is a Disarium number
# * 0 if N is not a Disarium number
################################################################################
sub is_disarium_number{
    my $n = int(shift());

    my $sum = 0;

    # Loop over each digit, summing its value raised to
    # the power of its position in the string
    for my $i (1 .. length($n)){
        $sum += substr($n, $i - 1, 1) ** $i;
    }

    # Indicate whether the sum is equal to the original
    # number or not
    return(
        $sum == $n ? 1 : 0
    );

}



