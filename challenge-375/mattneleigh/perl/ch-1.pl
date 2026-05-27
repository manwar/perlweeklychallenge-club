#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @string_sets = (
    [
        [ "apple", "banana", "cherry" ],
        [ "banana", "cherry", "date" ]
    ],
    [
        [ "a", "ab", "abc" ],
        [ "a", "a", "ab", "abc" ]
    ],
    [
        [ "orange", "lemon" ],
        [ "grape", "melon" ]
    ],
    [
        [ "test", "test", "demo" ],
        [ "test", "demo", "demo" ]
    ],
    [
        [ "Hello", "world" ],
        [ "hello", "world" ]
    ]
);

print("\n");
foreach my $string_set (@string_sets){
    printf(
        "Input: \@array1 = (%s)\n       \@array2 = (%s)\nOutput: %d\n\n",
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$string_set->[0]}
            )
        ),
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                @{$string_set->[1]}
            )
        ),
        unitary_list_match_count(@{$string_set})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given two arrays of strings, determine which words appear in both arrays, but
# only once in each array; comparisons between strings is case-sensitive (i.e.
# "Hello" and "hello" do not match)
# Takes two arguments:
# * A ref to the first array of strings to match (e.g.
#       [ "apple", "banana", "cherry" ]
#   )
# * A ref to the second array of strings to match (e.g.
#       [ "banana", "cherry", "date" ]
#   )
# Returns:
# * The number of strings that are found in both arrays but only once in each
#   (e.g.  2)
################################################################################
sub unitary_list_match_count{

    my %string_counts;
    my $string;
    my $matching_counts = 0;

    # Loop over the contents of the first list
    # and, farther below, the contents of the
    # second
    foreach $string (@{shift()}){
        # If we've seen this string before, add to
        # its count for the first list, otherwise
        # create a new pair of counts
        if(defined($string_counts{$string})){
            $string_counts{$string}[0]++;
        } else{
            $string_counts{$string} = [ 1, 0 ];
        }
    }
    foreach $string (@{shift()}){
        # If we've seen this string before, add to
        # its count for the second list; we DON"T
        # create a count pair for a string as yet
        # unseen as such strings by definition cannot
        # appear exactly once in both lists
        $string_counts{$string}[1]++
            if(defined($string_counts{$string}));
    }

    # Count the strings that appeared exactly
    # once in each list
    foreach $string (keys(%string_counts)){
        $matching_counts++
            if(
                ($string_counts{$string}[0] == 1)
                &&
                ($string_counts{$string}[1] == 1)
            );
    }

    return($matching_counts);

}



