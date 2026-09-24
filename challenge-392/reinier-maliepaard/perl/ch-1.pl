#!/usr/bin/perl
use strict;
use warnings;

sub convert_palindrome {

    my ($str) = @_;

    # Reverse does not change $str. It produces a reversed
    # copy, which is stored in $rev.
    my $rev = reverse $str;

    # Examine progressively shorter prefixes of the string.
    for (my $i = length($str) - 1; $i > 1; $i--) {

        # Extract the first $i characters of the string.
        my $prefix = substr($str, 0, $i);

        # Extract the last $i characters of the reversed string.
        #
        # A negative starting position counts from the end.
        # The last $i characters of the reversed string
        # correspond to the reverse of the first $i characters
        # of the original string.
        #
        # We compare those characters with $prefix.
        # If the two strings are equal, the prefix is a palindrome.
        if (substr($rev, -$i) eq $prefix) {

            # We have found the longest palindromic prefix
            # examined by the loop.
            #
            # The reversed suffix is placed in front of the
            # original string, producing a palindrome.
            return reverse(substr($str, $i)) . $str;
        }
    }


    # If the loop finishes, no palindromic prefix of length 2
    # or greater was found.
    #
    # Every string has a one-character palindromic prefix.
    #
    # Therefore, we can always create a palindrome by
    # reversing the string, except for its first character,
    # and placing that reversed part in front.
    #
    # The resulting string is a palindrome.
    return $rev . substr($str, 1);
}

# Tests

my $str;

# Example 1
print convert_palindrome ("pinnipeds"), "\n"; # Output: "sdepinnipeds"

# Example 2
print convert_palindrome ("abcd"), "\n"; # Output: "dcbabcd"

# Example 3
print convert_palindrome ("bananas"), "\n"; # Output: "sananabananas"

# Example 4
print convert_palindrome ("dissident"), "\n"; # Output: "tnedissident"

# Example 5
print convert_palindrome ("cailliachs"), "\n"; # Output: "shcailliachs"
