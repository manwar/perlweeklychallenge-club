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
# Run as: perl ch-2.pl < input-file
#

#
# Read input from standard input, assuming one exercise per line.
# Each line consists of a string $S, and a pattern $T, separated
# by whitespace.
#

#
# Recursively count matches:
#   - If either the string or the pattern is empty, there are no matches.
#   - Else, + count the matches if we don't match at the first character
#             if the string.
#           + if the first character of the string equals the first
#             character of the pattern:
#             o  add 1 if the pattern is just one character long
#             o  else, add the number of matches starting from the
#                then next character in the string, and the next
#                character in the pattern.
#
sub matches;
sub matches ($str, $pat) {
    return 0 if length ($str) == 0 || length ($pat) == 0;

    my $matches = matches substr ($str, 1), $pat;  # Don't match beginning
    if (substr ($str, 0, 1) eq substr ($pat, 0, 1)) {
        if (length ($pat) == 1) {
            $matches ++
        }
        else {
            $matches += matches substr ($str, 1), substr ($pat, 1);
        }
    }
    return $matches;
}

say matches split ' ' => $_ while <>;
