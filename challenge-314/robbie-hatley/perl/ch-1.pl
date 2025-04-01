#!/usr/bin/env -S perl -C63

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 314-1,
written by Robbie Hatley on Mon Mar 24, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 314-1: Equal Strings
Submitted by: Mohammad Sajid Anwar
You are given three strings. You are allowed to remove the
rightmost character of a string to make all equals. Write a
script to return the number of operations to make it equal,
otherwise -1.

Example #1:
Input: $s1 = "abc", $s2 = "abb", $s3 = "ab"
Output: 2
Operation 1: Delete "c" from the string "abc"
Operation 2: Delete "b" from the string "abb"

Example #2:
Input: $s1 = "ayz", $s2 = "cyz", $s3 = "xyz"
Output: -1

Example #3:
Input: $s1 = "yza", $s2 = "yzb", $s3 = "yzc"
Output: 3

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The first thing I note is that "-1" will be returned if-and-only-if the 3 input strings do NOT all start with
the same first character. (The examples rule-out the idea that 3 empty strings should be considered "equal".)
With that in-mind, I see two main ways to attack this:

1. Nibble from the right, chopping-off substrings until the 3 strings are equal, and count operations.
2. Count triplets of equal characters from the left, and subtract number of equal characters from total.

Either will give the same answer. I'll go with option 2, because it gives an easy way to determine when -1
should be returned: precisely when the number of equal characters (counted in triplets from the left) is 0
(or if any of the three strings is empty). With that in-mind, I'll make these 2 subroutines:

1. col($pref,$n)          (Return a column.)
4. del_unequ_chrs($pref)  (Delete unequal characters.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted strings, in proper Perl syntax, like so:
./ch-1.pl '(["asparagus","aspartame","asparkle"],["Robin","Robbie","Robert"],["rat","bat","cat"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8;
   use List::Util qw( min max sum0 all );

   # Return a column from a page:
   sub col ($pref,$n) {
      return map {substr $_, $n, 1} @$pref;
   }

   # If possible, make all lines of a page equal by deleting
   # characters from the right and return number of characters
   # deleted; otherwise, delete nothing and return -1:
   sub del_unequ_chrs ($pref) {
      my @lengths = map {length} @$pref;
      my $min_len =  min(@lengths);
      my $max_len =  max(@lengths);
      my $sum_len = sum0(@lengths);
      my $i = 0;
      for ( ; $i < $min_len ; ++$i ) {
         my @col = col($pref, $i);
         last unless all {$col[0] eq $_} @col;
      }
      # If at least the left-most column was equal, delete
      # everything past last contiguous equal column and
      # return number of characters deleted from page:
      if ( $i > 0 ) {
         map {$_ = substr($_, 0, $i)} @$pref;
         return ($sum_len - scalar(@$pref) * $i);
      }
      # Otherwise, delete nothing and return -1:
      else {
         return -1;
      }
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @pages = @ARGV ? eval($ARGV[0]) : (["abc", "abb", "ab"], ["ayz", "cyz", "xyz"], ["yza", "yzb", "yzc"]);
#                 Expected outputs :            2                    -1                      3

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $pref (@pages) {
   say '';
   say 'Page of text:';
   say for @$pref;
   my $removed = del_unequ_chrs($pref);
   if ( $removed > -1 ) {
      say 'Page with strings equalized:';
      say for @$pref;
      say "Number of unequal characters removed = $removed";
   }
   else {
      say 'These strings could not be equalized.';
   }
}
