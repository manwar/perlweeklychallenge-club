#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "  challenge  ",
    "coding  is  fun",
    "a b c  d",
    "  team      pwc  ",
    "   the  weekly  challenge  "
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: \"%s\"\n\n",
        $string,
        evenly_redistribute_spaces($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string consisting of words divided by spaces, rearrange the spaces so
# they are evenly devided amongs the gaps between the words; if there are
# spaces left over after this, add them to the end of the string
# Takes one argument:
# * The string to examine (e.g. "  team      pwc  ")
# Returns:
# * The provided string with all spaces apportioned evenly between the gaps in
#   the words, with excess spaces placed at the end (e.g. "team          pwc")
################################################################################
sub evenly_redistribute_spaces{
    # Split the string into words on spaces
    my @words = split(" ", $ARG[0]);
    my $spaces = shift();

    my $gaps = scalar(@words) - 1;
    my $recombined;

    # Count the spaces in the original string;
    # using the s/// operator this way will
    # return the number of spaces it removed
    $spaces = $spaces =~ s/\s//g;

    if($gaps){
        # There were gaps between multiple words-
        # apportion the spaces evenly between them,
        # and place the ramainder on the end
        $recombined = join(" " x int($spaces / $gaps), @words)
            .
            " " x ($spaces % $gaps);
    } else{
        # There were no gaps between words- place all
        # the spaces at the end of the single word
        $recombined = $words[0] . (" " x $spaces);
    }

    return($recombined);

}



