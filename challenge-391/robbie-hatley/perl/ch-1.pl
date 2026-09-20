#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 391-1,
written by Robbie Hatley on Mon Sep 14, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 391-1: Array Median
Submitted by: Mohammad Sajid Anwar
You are given two sorted arrays of numbers. Write a script to
merge the two given sorted arrays and return the median of the
merged array.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
"Merging" is just "my @a3 = sort {$a<=>$b} (@$a1, @$a2);". (Merge Sort won't work, because the problem doesn't
state whether the arrays are increasing, decreasing, or going in opposite directions. So I force increasing.)

"Median" depends on parity. For an odd number of elements, the median is the middle element. For an even
number of elements, the median is one half of the sum of the two middle elements.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must be a comma-separated pair of space-separated lists of real numbers. For example:

./ch-1.pl ' 35.2 -11.5 21.8 , 13.5 43.56 ' ' 5 2 , 3 1 4 '

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   $"=', ';

   # Find median of merge of two arrays of numbers:
   sub median_of_merge ( $aref ) {
      my @a3 = sort {$a<=>$b} (@{$aref->[0]}, @{$aref->[1]});
      my $n = scalar(@a3);
      if (0 == $n) {return 'undefined, due to no data'}
      my $mid_idx = int($#a3/2);
      # If $n is even, return half of sum of middle two elements:
      if (0 == $n%2) {return 0.5*($a3[$mid_idx]+$a3[$mid_idx+1]);}
      # Else if $n is odd, return middle element:
      else {return $a3[$mid_idx]}
   }

   # Trim non-glyph characters from the front and back of a string:
   sub trim_nonglyph ( $s ) {
      $s =~ s/\A[\pZ\p{Cc}\p{Cf}]*(.*?)[\pZ\p{Cc}\p{Cf}]*\z/$1/sr;
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
   [[2],[4]],                  # 3
   [[1, 2, 3], [7, 8, 9, 10]], # 7
   [[],[10, 20, 30, 40]],      # 25
   [[100],[1,2,3,4,5,6,7]],    # 4.5
   [[1,2,2],[2,2,3]],          # 2
   [[],[]],                    # undefined
   [[],[8]],                   # 8
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @array_strings = map {'['."@$_".']'} @$aref;
   say "Arrays: [@array_strings]";
   if (scalar(@$aref) != 2) {warn "Error: Wrong number of arrays (should be 2).\n"; next;}
   my $median = median_of_merge($aref);
   say "Median of merge of arrays = $median";
}
