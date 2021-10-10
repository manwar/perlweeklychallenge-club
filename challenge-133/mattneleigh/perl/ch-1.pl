#!/usr/bin/perl

use strict;
use warnings;

################################################################################
# Begin main execution
################################################################################

my @numbers = (10, 27, 85, 101);
my $number;

foreach $number (@numbers){
    printf(
        "Input: \$N = %d\nOutput: %d\n\n",
        $number,
        isqrt($number)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################


################################################################################
# Calculate the integer square root (that is to say, the largest integer less
# than or equal to the square root) of a supplied integer 
# Takes one argument:
# * A positive integer
# Returns on success:
# * The integer square root of the supplied integer
# Returns on error:
# * undef if a negative number is supplied
# Lazily adapted from an algorithm described at
# https://en.wikipedia.org/wiki/Integer_square_root
################################################################################
sub isqrt{
    my $n = int(shift());

    my $small_candidate;
    my $large_candidate;

    return(undef) if($n < 0);
    return($n) if($n < 2);

    $small_candidate = isqrt($n >> 2) << 1;
    $large_candidate = $small_candidate + 1;
    if(($large_candidate * $large_candidate) > $n){
        return($small_candidate);
    } else{
        return($large_candidate);
    }

}



