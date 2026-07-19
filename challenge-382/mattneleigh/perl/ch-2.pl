#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "01??0",
    "101",
    "???",
    "1?10",
    "1?1?0"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: (%s)\n\n",
        $string,
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                all_questionable_substitutions($string)
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string consisting of only ones (1), zeros (0), or question marks (?)
# generate a list of all possible variations of the original string in which
# which question marks have been replaced with zeros or ones
# Takes one argument:
# * The string to examine (e.g. "1?1?0")
# Returns:
# * A list of all possible variations of the original string in which question
#   marks in the original string are replaced with zeros or ones (e.g.
#   ( "10100", "10110", "11100", "11110" ) )
################################################################################
sub all_questionable_substitutions{
    my @chars = split("", shift());

    # Find out where the question marks are
    my @questions = map(
        $chars[$_] eq '?' ? $_ : (),
        0 .. $#chars
    );

    # Return the original string if there weren't
    # any question marks
    return(join("", @chars))
        unless(@questions);

    # Establish the maximum integer value that
    # can be represented with a number of bits
    # corresponding to the number of question
    # marks found earlier, and set up a format
    # for generating ones and zeros that
    # represent those values
    my $max = 2 ** @questions - 1;
    my $format = "\%0" . @questions . "b";

    return(
        # 2) Construct an array of strings with
        # question marks replaced with ones and zeros
        # from all the integers that can be
        # represented with a number of bits
        # corresponding to the number of question
        # marks
        map(
            {
                # 1) Use a array slice to replace the
                # question marks with bits from the current
                # integer, and recombine the characters into
                # a single string
                @chars[@questions] = split("", sprintf($format, $_));
                join("", @chars);
            }
            0 .. $max
        )
    );

}



