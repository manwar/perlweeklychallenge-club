#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @string_sets = (
    [
        [ "ad", "bd", "aaab", "baa", "badab" ],
        "ab"
    ],
    [
        [ "a", "b", "c", "ab", "ac", "bc", "abc" ],
        "abc"
    ],
    [
        [ "cc", "acd", "b", "ba", "bac", "bad", "ac", "d" ],
        "cad"
    ]
);

print("\n");
foreach my $string_set (@string_sets){
    printf(
        "Input: \@str = (%s)\n       \$allowed = \"%s\"\nOutput: %d\n\n",
        join(", ", map("\"" . $_ . "\"", @{$string_set->[0]})),
        $string_set->[1],
        count_consistent_strings($string_set->[1], @{$string_set->[0]})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Count the number of consistent strings within a set of strings- that is to
# say, the strings that only contain letters from a set of allowed letters;
# case will be ignored for matching purposes, as will be non-letter (not a-z)
# characters
# Takes two arguments:
# * A string containing "allowed" letters to be looked for in the other strings
#   (e.g. "cad" )
# * A list of other strings to examine (e.g. ( "cc", "acd", "b", "ba", "bac",
#   "bad", "ac", "d" ) )
# Returns:
# * The number of subsequent strings that were consistent- the ones that only
#   contained letters from the first string (e.g. 4 )
################################################################################
sub count_consistent_strings{
    # Make a hash from the allowed characters in
    # the first string, for easy lookup
    my %allowed = map(
        { $_ => 1 }
        unique_sorted_letters(shift())
    );
    my $count = 0;

    # Examine each remaining string
    foreach my $string (@ARG){
        my $increment = 1;

        # Compare each letter in the string with the
        # set of permitted letters
        foreach my $letter (unique_sorted_letters($string)){
            unless($allowed{$letter}){
                # Letter not allowed- clear the increment
                # flag and stop examining letters
                $increment = 0;
                last;
            }
        }

        # Increment count if all letters were
        # allowed
        $count++
            if($increment);
    }

    return($count);

}



################################################################################
# Given a string, produce a sorted array of unique letters therefrom; all
# letters are lower-cased, and all non-letter characters (not a-z) are ignored
# Takes one argument:
# * The string to examine (e.g. "Hello there!" )
# Returns:
# * A sorted list of the unique characters in the string (e.g. ( "e", "h", "l",
#   "o", "r", "t" ) )
################################################################################
sub unique_sorted_letters{
    # Store the sorted characters from the
    # arg with, all letters lower-cased
    my @chars = sort(split("", lc(shift())));
    my $i = 0;

    # Examine each character within the
    # (probably shrinking) list
    while($i <= $#chars){
        if(
            # Character is not a letter
            !($chars[$i] =~ m/[a-z]/)
            ||
            # Not the first character and it's a
            # duplicate of the previous char
            ($i && ($chars[$i] eq $chars[$i - 1]))
        ){
            # Remove it
            splice(@chars, $i, 1);
            next;
        }

        # Move on to the next character
        $i++;
    }

    return(@chars);

}



