#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @string_sets = (
    [
        [ "ab", "c" ],
        [ "a", "bc" ]
    ],
    [
        [ "ab", "c" ],
        [ "ac", "b" ]
    ],
    [
        [ "ab", "cd", "e" ],
        [ "abcde" ]
    ]
);

print("\n");
foreach my $string_set (@string_sets){
    printf(
        "Input: \@arr1 = (%s)\n       \@arr2 = (%s)\nOutput: %s\n\n",
        join(", ", map("\"" . $_ . "\"", @{$string_set->[0]})),
        join(", ", map("\"" . $_ . "\"", @{$string_set->[1]})),
        string_arrays_concatenate_uniformly($string_set) ?
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
# Given a ref to an array of arrays of strings (see below) determine whether
# the strings in each array concatenate to the same word/string
# Takes one argument:
# * A ref to an array of arrays of strings, of which there must be at least two
#   (e.g.
#       [
#           [ "ab", "cd", "e" ],
#           [ "abcde" ],
#           [ "abcd", "e" ]
#       ]
#   )
# Returns on success:
# * 0 if any array contains strings that do NOT concatenate to the same word as
#   all the others
# * 1 if all arrays contain strings that concatenate to the same word
# Returns on error:
# * undef if there are not at least two arrays of strings
################################################################################
sub string_arrays_concatenate_uniformly{

    # Need at least two arrays of strings
    return(undef)
        if(scalar(@{$ARG[0]}) < 2);

    my $baseword;

    # Examine each array of strings
    foreach my $i (0 .. $#{$ARG[0]}){
        my $word = "";

        # Concatenate each string in this array
        $word = join("", @{$ARG[0][$i]});

        if($i){
            # Not the first word concatenated...
            # return 0 if the new word doesn't match
            # the first one
            return(0)
                if($word ne $baseword);
        } else{
            # This is the first word concatenated-
            # store it
            $baseword = $word;
        }
    }

    # Everything matched
    return(1);

}



