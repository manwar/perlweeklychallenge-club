#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "hello",
    "perl",
    "raku"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %d\n\n",
        $string,
        calculate_string_score($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, compute the score of that string, where the score of a string
# is defined as the sum of the absolute difference between the ordinal values
# of adjacent characters
# Takes one argument:
# * The string to examine (e.g. "hello")
# Returns:
# * The score of the string, as defined above (e.g. 13)
################################################################################
sub calculate_string_score{

    my $old_val;
    my $new_val;
    my $sum = 0;

    # Grab the ordinal value of the first character
    $old_val = ord(substr($ARG[0], 0, 1));

    # Examine all remaining characters
    for my $pos (1 .. length($ARG[0]) - 1){
        # Grab the ordinal value of the next character,
        # accumulate the absolute value of the
        # difference between the previous character's
        # ordinal value and this one, then store this
        # one as the old value for the next iteration
        $new_val = ord(substr($ARG[0], $pos, 1));
        $sum += abs($old_val - $new_val);
        $old_val = $new_val;
    }

    return($sum);

}



