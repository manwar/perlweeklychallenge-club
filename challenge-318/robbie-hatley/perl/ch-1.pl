#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 318-1,
written by Robbie Hatley on Wed Apr 23, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 318-1: Task 1: Group Position
Submitted by: Mohammad Sajid Anwar
You are given a string of lowercase letters. Write a script to
find the position of all groups in the given string. Three or
more consecutive letters form a group. Return "" if none found.

Example #1:
Input: $str = "abccccd"
Output: "cccc"

Example #2:
Input: $str = "aaabcddddeefff"
Output: "aaa", "dddd", "fff"

Example #3:
Input: $str = "abcdd"
Output: ""

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I find the examples (which print group contents) to contradict the problem description (which asks for group
indexes). So I'll write a sub that gives both. All groups of 3+ contiguous identical characters in a string
can be found by matching the string to regexp "(.)\1{2,}" using the "m//" operator in scalar context in a
while loop. Then for each match $m I'll get its index $i within the string using "index", set next offset to
$i+1 (to start next index search one-past previous), and push ordered pair [$m,$i] to the output array.
After all matches (if any) have been found, I'll simply return the output array.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings of any characters, in proper Perl syntax, like so:

./ch-1.pl '("01101010001011011100101000","ppiiiiigg","茶銀銀金銀銀銀金茶茶銀銀銀金金金金茶茶茶")'


Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Find all places where a single-character group is immediately
   # followed by 2-or-more copies of itself. For each such case,
   # push to an output array an ordered pair consisting of
   # [match,index]. Then return the output array.
   sub group_position ($x) {
      my @o = () ; # Output array.
      my $m = '' ; # Match.
      my $i =  0 ; # Index of match.
      my $o =  0 ; # Offset for indexing.
      while ($x =~ m/(.)\1{2,}/g){ # For each group of 3+:
         $m = $&;              # Match.
         $i = index($x,$m,$o); # Index.
         $o = $i + 1; # Start next index search past last match.
         push @o,[$m,$i]}      # Push [$m,$i] to @o.
      @o}                      # Return @o.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   # Input:          # Expected output:

   "abccccd",        # cccc at index 2

   "aaabcddddeefff", # aaa at index 0
                     # dddd at index 5
                     # fff at index 11

   "abcdd"           # none
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
foreach my $string (@strings) {
   say '';
   my @matches = group_position($string);
   say "String = \"$string\"";
   say "Clusters of 3+ contiguous identical characters found:";
   if (0 == scalar @matches) {
      say "none";
   }
   else {
      for (@matches) {
         say "$_->[0] at index $_->[1]";
      }
   }
}
