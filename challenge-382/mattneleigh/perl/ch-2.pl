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
# You are given a string that contains only 0, 1 and ? characters.
# 
# Write a script to generate all possible combinations when replacing the question marks with a zero or one.
# 
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



