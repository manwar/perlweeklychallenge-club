#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Challenge
#
#   You are given 3 strings; $A, $B and $C.
#   
#   Write a script to check if $C is created by interleave $A and $B.
#   
#   Print 1 if check is success otherwise 0.
#

chomp (my $A = <>);
chomp (my $B = <>);
chomp (my $C = <>);

#
# $A, $B, $C are arrays, containing the single characters of
# the input strings. $ai, $bi, $ci are indices into the arrays
# (and can be seen as pointers into the strings). 
#
# Invariants:  - $ai + $bi == $ci
#              - @$C [0 .. $ci - 1] is an interleaving of
#                @$A [0 .. $ai - 1] and @$B [0 .. $bi - 1]
#
sub is_interleaved;
sub is_interleaved ($A, $B, $C, $ai = 0, $bi = 0, $ci = 0) {
    state $cache;
    local $" = "";
    $$cache [$ai] [$bi] //= do {
        #
        # If we have reached the end of either $A or $B,
        # what is remaining in the other string, must
        # match the unmatched part in $C.
        # 
        return "@$A[$ai..$#$A]" eq "@$C[$ci..$#$C]" if $bi == @$B;
        return "@$B[$bi..$#$B]" eq "@$C[$ci..$#$C]" if $ai == @$A;

        #
        # Now we can recurse; if the first character of unmatched
        # part of C matches the first character of the unmatched 
        # part of either A or B, we match the first character of C
        # and the first character of either A or B, and recurse.
        # If the first character of the unmatched part of C matches
        # the first character of unmatched parts of both A and B,
        # we first recurse first by matching against A, and if this
        # doesn't provide a match, we recurse by matching against B.
        #

        return $$A [$ai] eq $$C [$ci] &&
                     is_interleaved ($A, $B, $C, $ai + 1, $bi,     $ci + 1) ||
               $$B [$bi] eq $$C [$ci] &&
                     is_interleaved ($A, $B, $C, $ai,     $bi + 1, $ci + 1);
    }
}

#
# Check lengths; if the length of C isn't equal to the length of A
# plus the length of B, we cannot have a match. If the lengths check
# out, recursively check whether the strings are interleafed.
#

say length ($A) + length ($B) == length ($C) &&
    is_interleaved ([split // => $A],
                    [split // => $B],
                    [split // => $C]) ? 1 : 0;


__END__
