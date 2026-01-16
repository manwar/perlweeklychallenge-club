#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integers = ( 4, 5, 6, 7, 8 );

print("\n");
foreach my $integer (@integers){
    printf(
        "Input: \$int = %d\nOutput: %d\n\n",
        $integer,
        count_ones_in_kolakoski_sequence($integer)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a number $n of steps in the Kolakoski Sequence to examine, determine
# how many ones (1's) appear within the first $n digits of the sequence (though
# the sequence will tend to have more digits than this in total)
# See: https://en.wikipedia.org/wiki/Kolakoski_sequence
# Takes one argument:
# * The number of steps in the Kolakoski Sequence to execute AND the number of
#   digits therefrom to examine, which must be at least 3 (e.g. 6)
# Returns on success:
# * The number of ones in the portion of the sequence examined, as specified by
#   the supplied argument (e.g. 3)
# Returns on error:
# * undef if the supplied number is less than 3
################################################################################
sub count_ones_in_kolakoski_sequence{
    my $n = shift();

    # Don't proceed if the number is less than 3
    return(undef)
        if($n < 3);

    # Initial sequence values
    my $sequence = "122";

    # Perform the remaining steps
    for my $i (2 .. $n - 1){
        $sequence .= 
            substr($sequence, $i, 1) == 1 ?
                # $sequence at $i is 1
                $i % 2 ?
                    # Odd $i
                    "2"
                    :
                    # Even $i
                    "1"
                :
                # $sequence at $i is 2
                $i % 2 ?
                    # Odd $i
                    "22"
                    :
                    # Even $i
                    "11";

        # Break unless the sequence doesn't have
        # enough digits
        last
            unless(length($sequence) < $n);
    }

    # Use 'tr' to count the ones in the desired
    # portion of the sequence
    return(substr($sequence, 0, $n) =~ tr/1//);

}



