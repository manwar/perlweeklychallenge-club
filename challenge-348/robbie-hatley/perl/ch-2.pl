#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 348-2,
written by Robbie Hatley on Mon Nov 17, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 348-2: Convert Time
Submitted by: Mohammad Sajid Anwar
You are given two strings, $source and $target, containing time
in 24-hour time form. Write a script to convert the source into
target by performing one of the following operations:
1. Add  1 minute
2. Add  5 minutes
3. Add 15 minutes
4. Add 60 minutes
Find the total operations needed to get to the target.

Example #1:
Input: $source = "02:30"
       $target = "02:45"
Output: 1
One operation: "Add 15 minutes".

Example 2
Input: $source = "11:55"
       $target = "12:15"
Output: 2
Two operations: "Add 15 minutes", "Add 5 minutes".

Example 3
Input: $source = "09:00"
       $target = "13:00"
Output: 4
Four operations of "Add 60 minutes".

Example 4
Input: $source = "23:45"
       $target = "00:30"
Output: 3
Three operations of "Add 15 minutes".

Example 5
Input: $source = "14:20"
       $target = "15:25"
Output: 2
Two operations: "Add 60 minutes", "Add 5 minutes".

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll use this procedure:
1. Convert both times to minutes ($source -> $s, $target -> $t).
2. while ( $t < $s ) {$t += 1440}
3. my $ops = 0;
4. while ( $t - $s >= 60 ) {$s += 60; ++$ops}
5. while ( $t - $s >= 15 ) {$s += 15; ++$ops}
6. while ( $t - $s >=  5 ) {$s +=  5; ++$ops}
7. while ( $t - $s >=  1 ) {$s +=  1; ++$ops}
8. return $ops

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two double-quoted 24H times, in proper Perl syntax, like so:

./ch-2.pl '(["03:28", "23:19"],["21:44", "20:44"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Return number of operations to convert source to target:
   sub num_ops ( $src, $trg ) {
      my $s = 60 * (0 + substr $src, 0, 2) + 1 * (0 + substr $src, 3, 2);
      my $t = 60 * (0 + substr $trg, 0, 2) + 1 * (0 + substr $trg, 3, 2);
      my $ops = 0;
      while ( $t < $s ) {$t += 1440}
      while ( $t - $s >= 60 ) {$s += 60; ++$ops}
      while ( $t - $s >= 15 ) {$s += 15; ++$ops}
      while ( $t - $s >=  5 ) {$s +=  5; ++$ops}
      while ( $t - $s >=  1 ) {$s +=  1; ++$ops}
      $ops}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   ["02:30", "02:45"], # 1
   ["11:55", "12:15"], # 2
   ["09:00", "13:00"], # 4
   ["23:45", "00:30"], # 3
   ["14:20", "15:25"], # 2
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $src = $aref->[0];
   my $trg = $aref->[1];
   say "Source time = $src";
   say "Target time = $trg";
   my $ops = num_ops($src, $trg);
   say "Number of operations = $ops";
}
