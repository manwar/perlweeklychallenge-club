#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:

This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:

Solutions in Perl for The Weekly Challenge 248-1.
Written by Robbie Hatley on Sat Dec 23, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 248-1: Shortest Distance
Submitted by: Mohammad S Anwar
Rephrased by: Robbie Hatley
Given a string and a character in the given string, write a
script to return the array of distances abs(i-j) between each
index of the string and the index of the nearest copy of the
given character within the string, or print an error message
if the input is invalid.

Example 1:
Input: $str = "loveleetcode", $char = "e"
Output: (3,2,1,0,1,0,0,1,2,2,1,0)

Example 2:
Input: $str = "aaab", $char = "b"
Output: (3,2,1,0)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

This can be easily solved by using a pair of nested 3-part loops. The outer loop (over variable i) will look
at each index of the string, and the inner loop (over variable j) will look for the given character in the
string at distances starting from 0 and working up towards len($str), adding the first (and hence smallest)
distance found to the array of distances.

I'll also write a stipulation into the main loop that rejects any [string, character] pair that is malformed
(ref($array) neq 'ARRAY', or scalar(@$array) != 2, or len($str) < 1, or len($chr) != 1, or $str !~ /$chr/).

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of two-element arrays of double-quoted strings, with any apostrophes escaped with '"'"',
with the second element of each inner array consisting of 1 character, which must be in the first element,
in proper Perl syntax, like so:

To test error checking:
./ch-1.pl '(73, ["one", "two", "three"], ["", "q"], ["one", "two"], ["Frederick", "z"])'

To test correct operation:
./ch-1.pl '(["I go.", "."], ["She didn'"'"'t??? That'"'"'s detestable!!!", "d"],)'

Output is to STDOUT and will be each input string+character pair followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS AND MODULES USED:

use v5.38;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';
use Sys::Binmode;
use Time::HiRes 'time';

# ------------------------------------------------------------------------------------------------------------
# Global variables:
our $t0;     # Starting time.
our $db = 0; # Debug? Set to 0 for no, 1 for yes.

# ------------------------------------------------------------------------------------------------------------
# START TIMER:

BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Check for errors:
sub error($aref) {
   my $error;
   ref($aref) ne 'ARRAY'       and $error = "Error: \$aref is not a reference to an array."
   or scalar(@$aref) != 2      and $error = "Error: length of \@\$aref is not 2."
   or length($$aref[0]) < 1    and $error = "Error: \$str is empty."
   or length($$aref[1]) != 1   and $error = "Error: length of \$chr is not 1."
   or $$aref[0] !~ /$$aref[1]/ and $error = "Error: \$chr not found in \$str."
   or $error = 'ok';
   return $error;
}

# Calculate minimum distances:
sub minimum_distances ($str, $chr) {
   my @minimum_distances;
   OUTER:    for ( my $i = 0 ; $i < length($str) ; ++$i ) { # POSITION
      INNER: for ( my $j = 0 ; $j < length($str) ; ++$j ) { # DISTANCE
         if (    $i-$j >=     0        && substr($str, $i-$j, 1) eq $chr
              || $i+$j < length($str)  && substr($str, $i+$j, 1) eq $chr
            )
         {
            push(@minimum_distances, ($j));
            next OUTER;
         }
      }
   }
   return @minimum_distances;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Exacmple 1 Input:
   ['loveleetcode', 'e'],
   # Expected Output: (3,2,1,0,1,0,0,1,2,2,1,0)

   # Example 2 Input:
   ['aaab', 'b'],
   # Expected Output: (3,2,1,0)
);

$db and say 'Size of @arrays = ', scalar(@arrays);

# Main loop:
for my $aref (@arrays) {
   say '';
   my $error = error($aref);
   $error ne 'ok' and say $error and say "Moving on to next array." and next;
   my $str = $$aref[0];
   my $chr = $$aref[1];
   my @minimum_distances = minimum_distances($str, $chr);
   say "String = \"$str\"; character = \"$chr\"";
   say "Minimum distances = (", join(',', @minimum_distances), ")";
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
