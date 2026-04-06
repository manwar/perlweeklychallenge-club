#!/usr/bin/perl
use strict;
use warnings;

sub capital_detection {
    my ($str) = @_;

    # Die if any character is not A-Z or a-z

    die "Invalid string: contains non-letter characters\n" unless $str =~ /^[A-Za-z]+$/;

    # Check if string is:
    # - all uppercase: [A-Z]+
    # - all lowercase: [a-z]+
    # - capitalized:   [A-Z][a-z]+
    # Anchors ^ and $ ensure the whole string matches
    # (?:...) is a non-capturing group (no need to store the match)
    # Returns 1 if true, 0 otherwise

    return ($str =~ /^(?:[A-Z]+|[a-z]+|[A-Z][a-z]+)$/) ? 1 : 0;
}


# Tests

# Example 1
print capital_detection("Perl"), "\n"; # Output: 1

# Example 2
print capital_detection("TPF"), "\n"; # Output: 1

# Example 3
print capital_detection("PyThon"), "\n"; # Output: 0

# Example 4
print capital_detection("raku"), "\n"; # Output: 1
