#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 284-1,
written by Robbie Hatley on Sun Aug 25, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 284-1: Lucky Integer
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to
find the lucky integer if found otherwise return -1. If there
are more than one then return the largest. A lucky integer is
an integer that has a frequency in the array equal to its
value.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Abundance, pushing, and popping will be involved.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([3,4,3,7,4,7,2,7,4,7,2,7,3,4,7],[3,4,3,7,4,7,2,7,4,7,2,7,3,7],[3,4,3,7,4,7,2,7,4,7,2,7,7])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

sub lucky_integer {
   my %abundance; ++$abundance{$_} for @_;
   my @lucky = (-1);
   for (sort {$a<=>$b} keys %abundance) {
      push @lucky, $_ if $_ == $abundance{$_}
   }
   pop @lucky;
}

# ------------------------------------------------------------------------------------------------------------
# EXAMPLE INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([2, 2, 3, 4],[1, 2, 2, 3, 3, 3],[1, 1, 1, 3]);
# Expected outputs:                         2                3              -1

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   my @array = @$aref;
   my $lucky = lucky_integer @array;
   print "\n";
   print "Array = @array\n";
   print "Lucky Integer = $lucky\n";
}
