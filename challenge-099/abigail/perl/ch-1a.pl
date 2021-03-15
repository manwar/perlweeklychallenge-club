#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1a.pl < input-file
#

#
# Use a recursive method to see whether a pattern matches a string:
# ("PPP" is any pattern, possible empty; the string is of the form
#  "sSSS" (if non-empty), where "s" is any single character, and "SSS"
#  a possible empty substring).
#
#    - If both the string and pattern are empty, the match succeeds.
#    - If the string is empty:
#         o If the pattern is of the form "*PPP", the result is the
#           match of the string against "PPP"
#         o Else, the match fails.
#    - If pattern is the form "*PPP":
#         o if the pattern is "*", the match succeeds.
#         o if the pattern is of the form "**PPP", the result is the match
#           of the  string against "*PPP".
#         o if "SSS" (that is, the string without its leading character)
#           is matches by the pattern, the match succeeds
#         o if the pattern is of the form "*sPPP", or "*?PPP" (that is,
#           the character after the leading * is a ? or the first character
#           of the string), the results of the match is the match of
#           "SSS" against "PPP".
#         o else, the match fails.
#    - If the string is of the form "sSSS", and the pattern is of the
#      form "sPPP" or "?PPP", the result of the match is the match of
#      "SSS" against "PPP".
#    - Else, the match fails.
#

sub matches;
sub matches ($string, $pattern) {
    my $first_string   = length ($string)  > 0 ? substr ($string,  0, 1) : "";
    my $first_pattern  = length ($pattern) > 0 ? substr ($pattern, 0, 1) : "";
    my $second_pattern = length ($pattern) > 1 ? substr ($pattern, 1, 1) : "";

    if (!length $pattern) {
        #
        # If we have exhausted the pattern, we have a match
        # if, and only if, we have exhausted the string.
        #
        return length ($string) ? 0 : 1;
    }
    if (!length $string) {
        #
        # If we have exhausted the string, then if the pattern
        # starts with '*', we consume the '*' and recurse.
        # Else, the match fails.
        #
        return $first_pattern eq '*' ? matches ($string, substr ($pattern, 1))
                                     : 0;
    }

    if ($first_pattern eq "*") {
        #
        # If pattern is *, it's match, no matter what is in $string.
        #
        return 1 if $second_pattern eq "";

        #
        # If pattern starts with '**', consume one '*' and recurse.
        #
        return matches ($string, substr ($pattern, 1))
                 if $second_pattern eq "*";

        #
        # Try matching the first character of $string against '*',
        # and recurse -- if this is a match, return 1.
        #
        matches (substr ($string, 1), $pattern) && return 1;

        #
        # If the pattern starts with '*?', or '*X', where X is
        # the first character of $string, match the '*' with an
        # empty string, and the ? or X with the first character
        # of $string, and recurse.
        #
        return matches (substr ($string, 1), substr ($pattern, 2))
                 if $second_pattern eq "?" ||
                    $second_pattern eq $first_string;

        #
        # Else, it's a failure
        #
        return 0;
    }

    #
    # If the first character of $pattern matches the first character
    # of $string, or if the first character of $pattern equals '?',
    # match the first characters, and recurse with the rest.
    # Else, the match fails.
    #
    return $first_pattern eq $first_string ||
           $first_pattern eq "?" 
              ? matches (substr ($string, 1), substr ($pattern, 1))
              : 0
}
     

say matches split ' ' while <>;


__END__
