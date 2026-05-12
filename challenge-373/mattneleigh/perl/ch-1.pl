#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @array_sets = (
    [
        [ "a", "bc" ],
        [ "ab", "c" ]
    ],
    [
        [ "a", "b", "c" ],
        [ "a", "bc" ]
    ],
    [
        [ "a", "bc" ],
        [ "a", "c", "b" ]
    ],
    [
        [ "ab", "c", "" ],
        [ "", "a", "bc" ]
    ],
    [
        [ "p", "e", "r", "l" ],
        [ "perl" ]
    ]
);

print("\n");
foreach my $array_set (@array_sets){
    printf(
        "Input: \@arr1 = (%s)\n       \@arr2 = (%s)\nOutput: %s\n\n",
        map(
            join(
                ",",
                map(
                    "\"" . $_ . "\"",
                    @{$_}
                )
            ),
            @{$array_set}
        ),
        arrays_form_common_string(@{$array_set}) ?
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
# Given two arrays of strings, determine whether they, when each is
# concatenated, form identical strings
# Takes two arguments:
# * A ref to the first array of strings (e.g. [ "p", "e", "r", "l" ] )
# * A ref to the second array of strings (e.g. [ "pe", "rl" ] )
# Returns:
# * 0 if the two arrays do not concatenate to form identical strings
# * 1 if the two arrays concatenate to form identical strings (as would be the
#   case for the example above)
################################################################################
sub arrays_form_common_string{

    return(
        # Compare the concatenated arrays, and return
        # 1 or 0 appropriately
        join("", @{$ARG[0]}) eq join("", @{$ARG[1]}) ?
            1
            :
            0
    );

}



