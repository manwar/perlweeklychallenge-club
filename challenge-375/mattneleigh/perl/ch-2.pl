#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_sets = (
    [ 240,  2 ],
    [ 1020, 2 ],
    [ 444,  2 ],
    [ 17,   2 ],
    [ 123,  1 ]
);

print("\n");
foreach my $integer_set (@integer_sets){
    printf(
        "Input: \$num = %d, \$k = %d\nOutput: %d\n\n",
        $integer_set->[0],
        $integer_set->[1],
        compute_k_beauty(@{$integer_set})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a number and a single digit $k, determine the K-Beauty of the number,
# where K-Beauty is defined as the number of substrings of $k digits within the
# number that are integer divisors of the original number.  For example, an
# initial number of 2025 and a $k of 2 will yield the substrings "20", "02",
# "25"; of these, only 25 divides evenly into 2025, therefore the K-Beauty is
# 1.  If no substrings form numbers that divide evenly into the original, 0 is
# returned.
# Takes two arguments:
# * The number to examine (e.g. 444 )
# * The number of digits $k (e.g. 2 )
# Returns on success:
# * The K-Beauty of the given number, as defined above (e.g. 0 )
# Returns on error:
# * undef if $k is larger than the number of digits in the supplied number
################################################################################
sub compute_k_beauty{
    my $num = shift();
    my $k = shift();

    # A minor sanity check
    return(undef)
        if($k > length($num));

    my $substr_digits;
    my $beauty_count = 0;

    # Loop over the starting positions for
    # strings of length $k that fit within the
    # provided number
    for my $pos (0 .. length($num) - $k){
        $substr_digits = substr($num, $pos, $k);

        # Skip divisions by zero, for they are not
        # beautiful
        next
            if($substr_digits == 0);

        # Increment the beauty count if the original
        # can be divided evenly by the number in the
        # substring
        $beauty_count++
            unless($num % $substr_digits);
    }

    return($beauty_count);

}



