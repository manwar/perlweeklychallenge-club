#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "PeRlwEeKLy",
    "ChaLlenge",
    "The"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = '%s'\nOutput: %s\n\n",
        $string,
        find_greatest_letter($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string consisting solely of English letters (A-Z, a-z) determine
# which letter in the string is the greatest, where "greatest" means the
# highest-valued letter that appears in both lower and upper case within the
# string; if no qualifying letters are found, an empty string is returned
# Takes one argument:
# * The string to examine, which must consist solely of English letters (A-Z,
#   a-z, e.g. "PeRlwEeKLy" )
# Returns:
# * The greatest letter in the string, or an empty string if no qualifying
#   letters were found (e.g. "L" )
################################################################################
sub find_greatest_letter{

    my %letters;
    my $letter;

    foreach $letter (split('', $ARG[0])){
        # Store a true value for this letter in the
        # letter table- a field each for lower-case
        # and upper-case letters
        $letters{lc($letter)}[
            $letter =~ m/[a-z]/ ? 0 : 1
        ] = 1;
    }

    # Capture the first in a list of qualifying
    # letters sorted in descending order
    ($letter) = sort(
        { $b cmp $a }
        # Make a list of letters that appeared in
        # both upper and lower cases
        map(
            $letters{$_}[0] && $letters{$_}[1] ? $_ : (),
            keys(%letters)
        )
    );

    # Return the highest-valued qualifying
    # letter, or the empty string if none
    # were found
    return(
        defined($letter) ? uc($letter) : ""
    );

}



