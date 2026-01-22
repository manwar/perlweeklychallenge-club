#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @ints = ( 3524, 6174, 9998, 1001, 9000, 1111 );

print("\n");
foreach my $int (@ints){
    printf(
        "Input: \$int = %d\nOutput: %d\n\n",
        $int,
        count_kaprekar_iterations($int)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine how many iterations are required, using the methods defined in the
# article linked below, to reach Kaprekar's Constant (6174) from an initial
# four-digit number that consists of at least two types of digit
# Takes one argument:
# * The initial four-digit number to examine (e.g. 9998)
# Returns on success:
# * The number of iterations required to reach 6174 from the supplied number
#   (e.g. 5)
# Returns on error:
# * -1 if a number with other than four digits has been provided, or if the
#   number consists of the same digit repeated four times
# See also: https://en.wikipedia.org/wiki/6174
################################################################################
sub count_kaprekar_iterations{
    my $num = shift();

    # If the integer is already 6174, no need to
    # iterate; otherwise, make sure the integer
    # consists of exactly four digits of which at
    # least one differs from the other three
    return(0)
        if($num == 6174);
    return(-1)
        unless($num =~ m/^\d{4}$/ && $num !~ m/(\d)\1{3}/);

    my @digits = split("", $num);
    my $iterations = 0;

    while(join("", @digits) != 6174){
        # Sort digits in ascending order
        @digits = sort(@digits);

        # Subtract the value of the digits in descending
        # order from their value in ascending order
        @digits = split(
            "",
            join("", reverse(@digits)) - join("", @digits)
        );

        # Pad the result with leading zeros if required
        @digits = ((0, 0, 0)[0 .. 2 - $#digits], @digits)
            if(scalar(@digits) < 4);

        $iterations++;
    }

    return($iterations);

}



