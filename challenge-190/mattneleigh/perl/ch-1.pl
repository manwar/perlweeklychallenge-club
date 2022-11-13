#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @words = (
    "Perl",
    "TPF",
    "PyThon",
    "raku"
);

print("\n");
foreach my $word (@words){
    printf(
        "Input: \$s = '%s'\nOutput: %d\n\n",
        $word,
        correct_capital_usage($word)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string consisting only of alphabetic characters (e.g. A-Z, a-z),
# determines whether the use of capitalization is appropriate according to the
# following rules:
#   1) Only first letter is capital and all others are small.
#   2) Every letter is small.
#   3) Every letter is capital.
# Takes one argument:
# * The word to examine
# Returns:
# * 1 if the word matches any of the rules stated above
#   - OR -
# * 0 if the word does not match any of the rules stated above
################################################################################
sub correct_capital_usage{
    my $word = shift();

    return(1)
        if(
            # Rules arranged roughly in the order in
            # which they're most likely to be triggered
            # Rule 2
            ($word =~ m/^[a-z]+$/)
            ||
            # Rule 1
            ($word =~ m/^[A-Z][a-z]+$/)
            ||
            # Rule 3
            ($word =~ m/^[A-Z]+$/)
        );

    return(0);

}



