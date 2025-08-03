#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @words = (
    "weekly",
    "perl",
    "challenge"
);

print("\n");
foreach my $word (@words){
    printf(
        "Input: \$str = \"%s\"\nOutput: %s\n\n",
        $word,
        all_letters_odd($word) ? "true" : "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether each of the letters within a string occurs an odd number of
# times
# Takes one argument:
# * The string to examine (e.g. "Perl")
# Returns:
# * 0 if there is at least one letter that appears an even number of times
# * 1 if all letters appear an odd number of times (as would be the case in the
#   example above)
# NOTE: Non-letter characters are ignored; letter counting is case-insensitive-
# 'P' and 'p' are the same for counting purposes
################################################################################
sub all_letters_odd{

    my %letter_bits;
    my $letter;

    # Toggle an 0x01 bit for each letter in the supplied
    # string; if the final value for a letter is 0, that
    # letter appeared an even number of times
    foreach $letter (grep(/[a-z]/, split("", lc(shift())))){
        $letter_bits{$letter} ^= 0x01;
    }

    # See if there are any zeros among the values computed
    # for each letter; if so, a letter appeared an even
    # number of times
    if(grep(!$_, values(%letter_bits))){
        return(0);
    }

    # No even counts were found- return 1
    return(1);

}



