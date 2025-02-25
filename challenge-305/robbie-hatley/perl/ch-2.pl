#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 305-2,
written by Robbie Hatley on Mon Jan 20, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 305-2: "Alien Dictionary"
Submitted by: Mohammad Sajid Anwar
You are given a list of words and alien dictionary character
order. Write a script to sort lexicographically the given list of
words based on the alien dictionary characters.

Example #1:
Input: @words = ("perl", "python", "raku")
@alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/
Output: ("raku", "python", "perl")

Example #2:
Input: @words = ("the", "weekly", "challenge")
@alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/
Output: ("challenge", "the", "weekly")

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll first write a "compare" subroutine which compares two words according to a given
alphabet, then I'll write a "alien_dictionary" subroutine which sorts a given list of words by feeding them
(along with a given alphabet) to my "compare" subroutine.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two arrays, in proper Perl syntax. Each pair of innermost arrays should be
a list of words followed by a list of unique single-character strings which will be interpreted as an
alphabet for the purpose of sorting the list of words. For example:
./ch-2.pl '([["red","green","blue"],[qw( l n r b g e u d )]],[["bat","cat","ca"],[qw( c r b t )]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8;

   # Compare two words according to a given alphabet:
   sub compare ($aref, $word1, $word2) {
      my %index;
      for my $i (0..$#$aref) {
         $index{$$aref[$i]} = $i;
      }
      my $top = $#$aref + 1;
      for my $letter (split //, $word1) {
         if (!defined($index{$letter})) {
            $index{$letter} = $top++;
         }
      }
      for my $letter (split //, $word2) {
         if (!defined($index{$letter})) {
            $index{$letter} = $top++;
         }
      }
      my $l1=length($word1);
      my $l2=length($word2);
      my $smaller = ($l2 < $l1) ? $l2 : $l1;
      for my $i (0..$smaller-1) {
         return -1 if $index{substr($word1,$i,1)} < $index{substr($word2,$i,1)};
         return  1 if $index{substr($word1,$i,1)} > $index{substr($word2,$i,1)};
      }
      return -1 if $l1 < $l2;
      return  1 if $l1 > $l2;
      return 0;
   }

   # Sort a given list of words according to a given alphabet:
   sub alien_dictionary ($wref, $aref) {
      return sort {compare($aref,$a,$b)} @$wref;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   [
      ["perl", "python", "raku"],
      [qw( h l a b y d e f g i r k m n o p q j s t u v w x c z )]
   ],
   # Expected output: ("raku", "python", "perl")

   # Example #2 input:
   [
      ["the", "weekly", "challenge"],
      [qw( c o r l d a b t e f g h i j k m n p q s w u v x y z )]
   ],
   # Expected output: ("challenge", "the", "weekly"))
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @words = @{$$aref[0]};
   my @alpha = @{$$aref[1]};
   say "Words  = (@words)";
   say "Alpha  = (@alpha)";
   my @sorted = alien_dictionary($$aref[0],$$aref[1]);
   say "Sorted = (@sorted)";
}
