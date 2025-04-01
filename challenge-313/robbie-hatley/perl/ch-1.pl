#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 313-1,
written by Robbie Hatley on Tue Mar 18, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 313-1: Broken Keys
Submitted by: Mohammad Sajid Anwar
You have a broken keyboard which sometimes type a character more
than once. You are given a string and actual typed string. Write
a script to find out if the actual typed string is meant for the
given string.

Example #1:
Input: $name = "perl", $typed = "perrrl"
Output: true
Here "r" is pressed 3 times instead of 1 time.

Example #2:
Input: $name = "raku", $typed = "rrakuuuu"
Output: true

Example #3:
Input: $name = "python", $typed = "perl"
Output: false

Example #4:
Input: $name = "coffeescript", $typed = "cofffeescccript"
Output: true

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

“6accdae13eff7i3l9n4o4qrr4s8t12ux”
~~Sir Isaac Newton, Knight of The British Empire and Discoverer of Calculus and Physics

No, he didn't loose his mind or become senile. That's a "signature" of a document, basically the numbers
of each kind of letter which appear in the document.

And that's also the approach I'll use to solving PWCC task 313-1: I'll make "signature" arrays for the "$name"
and "$typed" strings, consisting of [letter, number] pairs indicating each contiguous group of identical
characters within each string. For "$typed" to match "$name", the two arrays must be of equal length, with the
same sequence of characters, with the multiplicity numbers of "$typed" being greater-than-or-equal-to the
corresponding multiplicity numbers of "$name".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two double-quoted strings, in proper Perl syntax, like so:
./ch-1.pl '(["Robbie", "Roobbbbbiiiee"], ["Hatley", "Hately"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8;

   # Is a second string a "broken keys" version of a first string?
   sub broken_keys ($x, $y) {
      my @xsig; # Signatures for first  string.
      my @ysig; # Signatures for second string.
      # Get list of signatures for first string:
      for ( my $prv = 0, my $idx = 0 ; $idx <= length($x) ; ++$idx ) {
         # If current char differs from char to left, store sig of previous cluster:
         if ( $idx == length($x) || substr($x, $idx, 1) ne substr($x, $idx-1, 1) ) {
            # Store the character at $previdx and the number of contiguous copies:
            push @xsig, [substr($x, $prv, 1), $idx-$prv];
            $prv = $idx;
         }
      }
      # Get list of signatures for second string:
      for ( my $prv = 0, my $idx = 0 ; $idx <= length($y) ; ++$idx ) {
         # If current char differs from char to left, store sig of previous cluster:
         if ( $idx == length($y) || substr($y, $idx, 1) ne substr($y, $idx-1, 1) ) {
            # Store the character at $previdx and the number of contiguous copies:
            push @ysig, [substr($y, $prv, 1), $idx-$prv];
            $prv = $idx;
         }
      }
      # If the lengths don't match, $y is not broken-key version of $x:
      if ( scalar(@xsig) != scalar(@ysig) ) {return 'false';}
      for my $idx (0..$#xsig) {
         # If the characters don't match, $y is not broken-key version of $x:
         if ( $xsig[$idx]->[0] ne $ysig[$idx]->[0] ) {return 'false';}
         # If any of $x's repetitions exceed those of $y, $y is not broken-key:
         if ( $xsig[$idx]->[1]  > $ysig[$idx]->[1] ) {return 'false';}
      }
      # If we get to here, $y is a broken-key version of $x:
      return 'true';
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   ["perl",         "perrrl"          ], # Expected output: true
   ["raku",         "rrakuuuu"        ], # Expected output: true
   ["python",       "perl"            ], # Expected output: false
   ["coffeescript", "cofffeescccript" ], # Expected output: true
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $name   = $aref->[0];
   my $typed  = $aref->[1];
   my $broken = broken_keys($name, $typed);
   say "Original name: $name";
   say "Name as typed: $typed";
   say "Due to broken keys? $broken";
}
