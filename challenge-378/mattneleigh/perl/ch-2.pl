#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @string_lists = (
    [ "acb", "cba", "cdb" ],
    [ "aab", "aac", "ad" ],
    [ "bc", "je", "jg" ],
    [ "a", "aaaa", "aa" ],
    [ "c", "d", "h" ],
    [ "gfi", "hbf", "bdhd" ]
);

print("\n");
foreach my $string_list (@string_lists){
    printf(
        "Input: \$str1 = \"%s\", \$str2 = \"%s\", \$str3 = \"%s\"\n"
            .
            "Output: %s\n\n",
        @{$string_list},
        verify_translated_sum(@{$string_list}) ?
            "true"
            :
            "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given three strings of lower case English letters in the range of 'a' to 'j',
# assign values of 0 to 9 to these letters (a -> 0, b -> 1, etc.) and determine
# whether the first two resulting numbers add up to the third
# Takes one argument:
# * The list of strings to examine (e.g. ("acb", "cba", "cdb") )
# Returns:
# * 0 if the numbers created from the first two strings do not add up to the
#   number created from the third string
# * 1 if the numbers created from the first two strings add up to the number
#   created from the third string (as would be in the case above, because
#   021 + 210 = 231 )
################################################################################
sub verify_translated_sum{

    # Convert the strings into numbers according
    # to the rules described above
    my @numbers = map(
        join(
            "",
            map(
                ord($_) - 97,
                split("", $_)
            )
        ),
        @ARG
    );

    # Determine whether the sum of the first two
    # numbers matches the third, and return an
    # appropriate value
    return(
        $numbers[0] + $numbers[1] == $numbers[2] ?
            1
            :
            0
    );

}



