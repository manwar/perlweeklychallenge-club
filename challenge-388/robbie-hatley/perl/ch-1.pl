#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 388-1,
written by Robbie Hatley on Mon Aug 24, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 388-1: Dyck Words
Submitted by: Mohammad S Anwar
A Dyck Word of order $n is a string of length 2x$n consisting of
$n ‘U’ (Up) characters and $n ‘D’ (Down) characters such that no
initial prefix of the string contains more ‘D’s than ‘U’s.

Write a script to return a list of all valid Dyck words of
length 2x$n, sorted in lexicographical (alphabetical) order.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I first generate likely candidate equivalent integers (with the correct number of binary digits, beginning
with 1 and ending with 0). I then check each candidate to see if it actually is a Dyck number. For each
Dyck number, I sprintf it as a binary number, transliterate 01 to DU, quote it, and push it to a list.
Finally, I return the list. (There is no need to sort the list, as the fact that I generate candidates in
increasing order means that the final list is already in sorted.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one-or-more space-separated
arguments which must be non-negative integers. For example:

./ch-1.pl 0 1 3 5 9 11

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   $"=', ';

   # Is a given integer a Dyck number?
   sub is_Dyck ($b) {
      my $l = 0; my $t = $b; ++$l,$t>>=1 while $t;
      my $UD = 0;
      for ( my $i = 0 ; $i < $l ; ++$i ) {
         my $digit = 1&$b>>($l-$i-1);
         $digit ? ++$UD : --$UD;
         return 0 if $UD < 0;
      }
      return 0 if 0 != $UD;
      return 1;
   }

   # Generate all order-n Dyck words:
   sub Dyck ( $n ) {
      return ('""') if $n < 1;
      my @words;
      for ( my $num = 2**(2*$n-1) ; $num <= 2**(2*$n)-2 ; $num += 2) {
         if (is_Dyck($num)) {
            push @words, '"' . sprintf("%b", $num) =~ tr/01/DU/r . '"';
         }
      }
      return @words;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @nums = @ARGV ? @ARGV : (1,2,3,0,4);

=pod

Expected outputs for various examples:

Example 1
Input: $n = 1
Output: ("UD")

Example 2
Input: $n = 2
Output: ("UDUD","UUDD")

Example 3
Input: $n = 3
Output: ("UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD")

Example 4
Input: $n = 0
Output: ("")

Example 5
Input: $n = 4
Output: ("UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD",
         "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD",
         "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD")

=cut

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $num (@nums) {
   say '';
   my @Dyck = Dyck($num);
   say "List of all order-$num Dyck words = (@Dyck)";
}
