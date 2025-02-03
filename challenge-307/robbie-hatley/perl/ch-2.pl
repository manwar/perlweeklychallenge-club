#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 307-2,
written by Robbie Hatley on Mon Feb 03, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 307-2: Find Anagrams
Submitted by: Mohammad Sajid Anwar
You are given a list of words, @words. Write a script to find
any two consecutive words and if they are anagrams, drop the
first word and keep the second. You continue this until there
is no more anagrams in the given list and return the count of
final list.

Example #1:
Input: @words = ("acca", "dog", "god", "perl", "repl")
Output: 3
Step 1: "dog" and "god" are anagrams, so dropping "dog" and
        keeping "god" => ("acca", "god", "perl", "repl")
Step 2: "perl" and "repl" are anagrams, so dropping "perl"
        and keeping "repl" => ("acca", "god", "repl")

Example #2:
Input: @words = ("abba", "baba", "aabb", "ab", "ab")
Output: 2
Step 1: "abba" and "baba" are anagrams, so dropping "abba"
        and keeping "baba" => ("baba", "aabb", "ab", "ab")
Step 2: "baba" and "aabb" are anagrams, so dropping "baba"
        and keeping "aabb" => ("aabb", "ab", "ab")
Step 3: "ab" and "ab" are anagrams, so dropping "ab" and
        keeping "ab" => ("aabb", "ab")

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
One simple way to solve this would be to sort the letters of the words, but I'll use a different approach:
I'll make a "signature" for each word, using the method Newton used in his famous letter to Liebnitz.
For example, sig("parrot") = "a1o1p1r2t1".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted all-lower-case English words, in proper Perl syntax, like so:
./ch-2.pl '(["rabbit", "tar", "rat", "mole"], ["green", "tab", "bat", "poop"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   # Return the Newtonian signature of a word:
   sub sig {
      my $word = shift;
      my @chrs = split //, $word;
      my %hash;
      for (@chrs) {
         ++$hash{$_};
      }
      my $sig = '';
      for (sort keys %hash) {
         $sig .= $_;
         $sig .= $hash{$_};
      }
      return $sig;
   }

   # Are two words anagrams of each other?
   sub are_anagrams {
      return(sig($_[0]) eq sig($_[1]));
   }

   # Remove the first of each pair of consecutive anagrams:
   sub trim_anagrams {
      my @wrds = @_;
      for ( my $i = 0 ; $i <= $#wrds-1 ; ++$i ) {
         if (are_anagrams($wrds[$i],$wrds[$i+1])) {
            splice(@wrds, $i, 1);
            --$i;
         }
      }
      return @wrds;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Input:                                # Expected output:
   ["acca", "dog", "god", "perl", "repl"], # 3
   ["abba", "baba", "aabb", "ab", "ab"],   # 2
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   print "\n";
   my @words = @$aref;
   my @prune = trim_anagrams(@words);
   my $psize = scalar(@prune);
   print "Original array   = (@words)\n";
   print "Without anagrams = (@prune)\n";
   print "Pruned size      = $psize\n";
}
