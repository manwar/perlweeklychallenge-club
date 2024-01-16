#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 249-2.
Written by Robbie Hatley on Fri Dec 29, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 249-2: DI String Match
Submitted by: Mohammad S Anwar
Given a string s, consisting of only the characters "D" and "I",
find a permutation of the integers [0 .. length(s)] such that
for each character s[i] in the string:
s[i] == 'I' ⇒ perm[i] < perm[i + 1]
s[i] == 'D' ⇒ perm[i] > perm[i + 1]

Example 1:
Input: $str = "IDID"
Output: (0, 4, 1, 3, 2)

Example 2:
Input: $str = "III"
Output: (0, 1, 2, 3)

Example 3:
Input: $str = "DDI"
Output: (3, 2, 0, 1)


--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
There's probably a "cute trick" way to do this, but I can't see what it is, and I'm not willing to waste
hours this weekend trying to figure it out, so I'll use the "obvious" method instead: I'll use the permute()
function from CPAN module Math::Combinatorics to make all possible permutations of 0..$length and return the
first which meets the given requirements, or an empty array if the requirements cannot be met.

Addendum: I found that multiple valid answers exist for most compliant strings.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings consisting only of "D" and "I" characters, in proper Perl syntax:
./ch-2.pl '("She didn'"'"'t eat clams.", "DIDI", "IIDII", "DIDIIDD", "IIIDDDIII")'

Output is to STDOUT and will be each input string followed by the corresponding output array (or an empty
array if the given requirements cannot be met).

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
use Math::Combinatorics 'permute';

# ------------------------------------------------------------------------------------------------------------
# GLOBAL VARIABLES:
our $t0     ; # Seconds since 00:00:00 on Thu Jan 1, 1970.
our $db = 0 ; # Debug? Set to 0 for no, 1 for yes.

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Return an error message if $string isn't a non-empty string consisting purely of 'D' and 'I' characters,
# or 'ok' if it is:
sub error ($string) {
   my $error;
   'SCALAR' ne ref(\$string) and $error = 'Error: String is not a string.'
   or $string !~ m/^[DI]+$/  and $error = 'Error: String must consist of D and I characters only'
   or $error = 'ok';
   return $error;
}

# Return a permutation of 0..length($string) meeting the
# requirements given in the problem description, or return
# an empty array if no suitable permutation exists:
sub decrease_increase ($string) {
   my $n = length $string;
   my @permutations = permute(0..$n);
   PERMUTATION: for my $permutation (@permutations) {
      $db and say '(' . join(', ', @$permutation) . ')';
      for ( my $i = 0 ; $i < $n ; ++$i ) {
         my $char = substr($string, $i, 1);
         $db and say "character i = $char";
         # If either of these two violations occur, this is not a compliant permutation:
         'I' eq $char && $permutation->[$i] > $permutation->[$i+1] and next PERMUTATION;
         'D' eq $char && $permutation->[$i] < $permutation->[$i+1] and next PERMUTATION;
      }
      # If we get to here, this is the first compliant permutation we've found, so return it:
      return @$permutation;
   }
   # If we get to here, no permutation was compliant, so return an empty array:
   return ();
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   "IDID",
   # Expected Output: (0, 4, 1, 3, 2)

   #Example 2 Input:
   "III",
   # Expected Output: (0, 1, 2, 3)

   #Example 3 Input:
   "DDI",
   # Expected Output: (3, 2, 0, 1)
);

# Main loop:
for my $string (@strings) {
   # Start by printing a blank line:
   say '';
   # Announce this string:
   say "String = $string";
   # Skip to next string if string is non-compliant:
   my $error = error($string);
   'ok' ne $error and say $error and say 'Skipping to next string.' and next;
   # Attempt to get compliant permutation:
   my @DI = decrease_increase($string);
   0 == scalar @DI and say 'Unable to form decrease/increase permutation' and next
   or say 'decrease/increase permutation: ' and say '('.join(', ', @DI).')';
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
