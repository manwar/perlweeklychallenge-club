#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 391-2,
written by Robbie Hatley on Tue Sep 15, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 391-2: Arrange Box
Submitted by: Mohammad Sajid Anwar
You are given an array of box dimensions. Write a script to
determine the maximum number of these boxes that can fit inside
each other in a single stack. For a box to fit inside another,
it must be smaller in both dimensions.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

To solve this, I first needed to find a nesting algorithm. And I found one. It revolves around sorting the
boxes ascending-by-width then descending-by-depth for equal width. If one then extracts the depths, any
strictly-increasing subsequences within the depths are associated with box sequences which nest. Hence the
length of the longest strictly-increasing subsequence of the sequence of depths is the maximum number of boxes
which can be nested.

So then I needed to find an algorithm for computing "Length Of Longest Strictly-Increasing Subsequence"
(or "LOLSIS" for short) of any finite sequence of integers. And I found several.

The simplest approach is to generate all subsequences, discard the ones which are not strictly-increasing,
and note the length of the longest of the remainder. This works and is conceptually simple, but has
exponential complexity.

More-efficient is the method of keeping track of "length of longest strictly-increasing subsequence ending
HERE" at each point in the sequence. This has quadratic complexity.

But I eventually settled on a different algorithm, the "least tails" method. This method keeps an array
"@tails" such that $tails[$i] = "least ending value (tail) seen so far for strictly-increasing subsequences
of length $i". At first I felt disinclined to also provide a binary search; but in the end I figured that
since I've already gone through the hassle of implementing an exceedingly-non-intuitive algoritm, I might as
well take it all the way and make a version which has O(n log n) complexity.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must consist of a comma-separated sequence of lists. Each list must consist of a
space-separated pair of positive integers. For example:

./ch-2.pl ' 3 8 , 4 32 , 17 11 , 5 9 , 13 13 ' ' 14 14 , 8 8 , 9 17 , 9 9 , 7 6 , 15 16 '

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   $"=', ';

   # How much is that doggy in the window? The one with the waggly tail.
   # (Length Of Longest Strictly-Increasing Subsequence - "least tails" method - O(n log n) complexity)
   sub LOLSIS ( @sequence ) {
      # Keep track of least tail (ending number) found so far for each length of
      # Strictly-Increasing Subsequences (SISs).
      # Waggly_tails[1] = least tail for length-1 subsequences
      # Waggly_tails[2] = least tail for length-2 subsequences
      # ... etc ... :
      my @waggly_tails;
      # Keep track of "greatest LOLSIS seen so-far":
      my $LOLSIS = 0;
      # For each $number in @sequence, assign $waggly_tails[$i] = $number for the smallest value of $i for
      # which $number <= $waggly_tails[$i]. This indicates that $number is a new least tail (ending number)
      # for SISs of length $i.
      for my $number (@sequence) {
         my ($i, $j, $k);
         for ( $i = 1 , $k = $LOLSIS+1 ; $i < $k ; ) {
            $j = int(($i+$k)/2);
            if ($number > $waggly_tails[$j]) {$i = $j + 1;}
            else {$k = $j;}
         }
         $waggly_tails[$i] = $number;
         # If we just found "longest SIS seen so-far", update $LOLSIS:
         if ($i > $LOLSIS) {$LOLSIS = $i;}
      }
      # $LOLSIS will now be equal to Length Of Longest Strictly-Increasing Subsequence:
      $LOLSIS;
   }

   # Little boxes on the hillside, little boxes made of ticky-tacky.
   # (How many boxes can we nest?)
   sub boxes ( $aref ) {
      # Get boxes from array reference:
      my @boxes  = @$aref;
      # Cross-sort boxes: first ascending  by width,
      #                   then  descending by depth:
      my @sorted = sort {$a->[0]<=>$b->[0]||$b->[1]<=>$a->[1]} @boxes;
      # Any strictly-increasing sub-sequence of depths will correspond to a sequence of boxes which is
      # strictly-increasing in both width AND depth and hence are nesting. Hence Length Of Longest
      # Strictly-Increasing Subsequence (LOLSIS) of depths is also maximum nesting of boxes:
      my @depths = map {$_->[1]} @sorted;
      LOLSIS @depths;
   }

   # Trim non-glyph characters from the front and back of a string:
   sub trim_nonglyph ( $s ) {
      my $n = '[\pZ\p{Cc}\p{Cf}]';
      $s =~ s/\A$n*(.*?)$n*\z/$1/sr;
   }

   # Parse lists of lists:
   sub parse_argv_2 ( @bash_args ) {
      my @args = ();
      foreach my $bash_arg (@bash_args) {
         my @lst_strs = map {trim_nonglyph $_} split ',', $bash_arg;
         push @args, [map {[split /\s+/, $_]} @lst_strs];
      }
      return @args;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? parse_argv_2(@ARGV) :
(
   [ [1, 3], [3, 5], [6, 8], [2, 4]                   ] , # 4
   [ [4, 5], [4, 6], [6, 7], [2, 3], [4, 3]           ] , # 3
   [ [5, 5], [5, 5], [5, 5]                           ] , # 1
   [ [2, 100], [3, 200], [4, 300], [5, 50], [5, 400]  ] , # 4
   [ [10, 20], [15, 10], [20, 30], [12, 18], [16, 25] ] , # 3
   [                                                  ] , # 0
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @box_strings = map {'['.$_->[0].', '.$_->[1].']'} @$aref;
   say "Boxes = @box_strings";
   my $greatest_nest = boxes($aref);
   say "Greatest number of boxes which can be nested = $greatest_nest";
}
