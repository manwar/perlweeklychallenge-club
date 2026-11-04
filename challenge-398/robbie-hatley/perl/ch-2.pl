#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 398-2,
written by Robbie Hatley on Tue Nov 03, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 398-2: String Difference
Submitted by: Mohammad Sajid Anwar
You are given an array of equal length strings. Write a script
to find the difference integer array of each word in the given
array. There will be one word with a different array; return
that word. Each words[i] can be converted into a difference
integer array difference[i] of length n - 1 where
difference[i][j] = words[i][j+1] - words[i][j]

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

The problem description assumes that the input data has been tailored to make the program's output come out as
desired. I find that assumption unwarranted, so I'll elect to write the program such that it can accept any
arrays of equal-length strings, whether there exist any words with unique difference arrays or not.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments. Each argument must be a comma-separated list of strings. For example:

./ch-2.pl 'bairn,cairn,torch' '麦藁雪,富士川,町山梨' 'cab,jhi,pno,nit'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   use utf8::all;
   $"=', ';

   # What is the difference signature of a string?
   sub diff_sig ( $s ) {
      my @chars = split //, $s;
      my $n = scalar(@chars);
      my @diffs;
      for ( my $i = 1 ; $i < $n ; ++$i ) {
         push @diffs, ord($chars[$i]) - ord($chars[$i-1]);
      }
      join ' ', @diffs;
   }

   # Which, if any, strings in a list have unique diff sigs?
   sub unique_diff ( $aref ) {
      my %h;
      for my $s (@$aref) {
         push @{$h{diff_sig($s)}}, $s;
      }
      my @u;
      for my $s (@$aref) {
         if (1 == scalar(@{$h{diff_sig($s)}})) {
            push @u, $s;
         }
      }
      @u;
   }

   # Parse lists of strings:
   sub parse_argv_1 ( @bash_args ) {
      my @args = ();
      foreach my $bash_arg (@bash_args) {
         push @args, [map {trim $_} split /,/, $bash_arg, -1];
      }
      return @args;
   }

   # Is a given scalar a ref to an array of 1-or-more equal-length strings?
   sub valid ( $aref ) {
      return false unless 'ARRAY' eq reftype $aref;
      return false unless 0 < scalar @$aref;
      my $l = length($$aref[0]);
      for my $s (@$aref) {
         return false unless length($s) == $l;
      }
      return true;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? parse_argv_1(@ARGV) :
(
   ["ab", "bc", "cd", "zy"],         # ("zy")
   ["cba", "fed", "azy"],            # ("azy")
   ["pop", "ada", "beb", "cfc"],     # ("pop")
   ["aaaa", "zzzz", "mmmm", "aaba"], # ("aaba")
   ["aceg", "bdfh", "cegi", "azbz"], # ("azbz")
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   if (!valid($aref)) {
      warn "Error: Input must be a comma-separated list of equal-length strings.\n";
      next;
   }
   say 'Strings (with difference signatures):';
   for my $s (@$aref) {
      my $ds = diff_sig($s);
      say "$s ($ds)";
   }
   my @u = unique_diff($aref);
   say "Strings with unique differences: (@u)";
}
