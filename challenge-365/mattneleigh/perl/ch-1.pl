#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @letter_sets = (
    [ "abc",  1 ],
    [ "az",   2 ],
    [ "cat",  1 ],
    [ "dog",  2 ],
    [ "perl", 3 ]
);

print("\n");
foreach my $letter_set (@letter_sets){
    printf(
        "Input: \$str = \"%s\", \$k = %d\nOutput: %d\n\n",
        $letter_set->[0],
        $letter_set->[1],
        letter_to_digit_summation(@{$letter_set})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string of lower-case English letters and in integer, convnert the
# string into a number by way of converting each letter into a number from 1 to
# 26 inclusive, then concatenating all the resulting digits; after this
# conversion, iterate over the digit set a specified number of times, summing
# all the digits of the current number to compute a new one (i.e. "abcde" ->
# 12345 -> 15 -> 6).  When the specified number of iterations has been
# completed, the resulting value will be returned
# Takes two arguments:
# * The string to process (e.g. "perl")
# * The number of iterations to perform (e.g. 3)
# Returns:
# * The number resulting from running the specified number of iterations of the
#   method described above (e.g. 6)
################################################################################
sub letter_to_digit_summation{
    use List::Util qw(sum);

    # Create a concatenated set of digits from
    # the input string
    my $num = join(
        "",
        map(
            ord($_) - 96,
            split(
                "",
                shift()
            )
        )
    );
    my $k = shift;

    # Sum the digits of the current number, the
    # specified number of times
    while($k--){
        $num = sum(split("", $num));
    }

    return($num);

}



