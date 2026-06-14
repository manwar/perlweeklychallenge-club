#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @string_lists = (
    [ "a", "aba", "ababa", "aa" ],
    [ "pa", "papa", "ma", "mama" ],
    [ "abao", "ab" ],
    [ "abab", "abab" ],
    [ "ab", "abab", "ababab" ],
    [ "abc", "def", "ghij" ]
);

print("\n");
foreach my $string_list (@string_lists){
    printf(
        "Input: \@array = (%s)\nOutput: %d\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$string_list}
            )
        ),
        count_suffix_prefix_pairs(@{$string_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of strings, determine how many strings within the array are a
# prefix AND a suffix of another string (i.e.  "ab" is a prefix and suffix of
# "abcdeab") within the array, noting that occurrences as prefix and suffix may
# overlap
# Takes one argument:
# * The array of strings to examine (e.g. ("ab", "abab", "ababab") )
# Returns:
# * The number of strings within the array that are both a prefix and a suffix
#   of another string in the array (e.g. 3 )
################################################################################
sub count_suffix_prefix_pairs{

    my $i;
    my $j;
    my $count = 0;
    my $length_i;
    my $length_j;

    # Loop over all possible pairs of strings
    for $i (0 .. $#ARG - 1){
        $length_i = length($ARG[$i]);

        for $j ($i + 1 .. $#ARG){
            $length_j = length($ARG[$j]);

            # Increment the count if...
            $count++
                if(
                    (
                        # ...string j fits within string i...
                        ($length_i >= $length_j)
                        &&
                        # ...and string j is a prefix of string i...
                        (substr($ARG[$i], 0, $length_j) eq $ARG[$j])
                        &&
                        # ...and string j is a suffix of string i...
                        (substr($ARG[$i], -$length_j) eq $ARG[$j])
                    )
                    # ...OR...
                    ||
                    (
                        # ...string i fits within string j...
                        ($length_j >= $length_i)
                        &&
                        # ...and string i is a prefix of string j...
                        (substr($ARG[$j], 0, $length_i) eq $ARG[$i])
                        &&
                        # ...and string i is a suffix of string j
                        (substr($ARG[$j], -$length_i) eq $ARG[$i])
                    )
                );
        }
    }

    return($count);

}



